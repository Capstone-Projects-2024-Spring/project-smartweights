import bluetooth
import random
import struct
import time
import micropython
from ble_advertising import decode_services, decode_name
from micropython import const
from machine import Pin

_IRQ_SCAN_RESULT = const(5)
_IRQ_SCAN_DONE = const(6)
_IRQ_PERIPHERAL_CONNECT = const(7)
_IRQ_GATTC_SERVICE_RESULT = const(9)
_IRQ_GATTC_SERVICE_DONE = const(10)
_IRQ_GATTC_CHARACTERISTIC_RESULT = const(11)
_IRQ_GATTC_CHARACTERISTIC_DONE = const(12)
_IRQ_GATTC_READ_RESULT = const(15)

_ADV_IND = const(0x00)

# org.bluetooth.service.environmental_sensing
_ENV_SENSE_UUID = bluetooth.UUID(0x181A)
# org.bluetooth.characteristic.temperature
_TEMP_UUID = bluetooth.UUID(0x2A6E)
_TEMP_CHAR = (
    _TEMP_UUID,
    bluetooth.FLAG_READ | bluetooth.FLAG_NOTIFY,
)
_ENV_SENSE_SERVICE = (
    _ENV_SENSE_UUID,
    (_TEMP_CHAR,),
)

class BLETemperatureCentral:
    def __init__(self, ble):
        self._ble = ble
        self._ble.active(True)
        self._ble.irq(self._irq)
        self._reset()
        self._led = Pin('LED', Pin.OUT)

    def _reset(self):
        # Cached names, addresses, and handles for connected peripherals.
        self._peripherals = []

        # Callback for when new data is notified from a device.
        self._notify_callback = None

    def _irq(self, event, data):
        if event == _IRQ_SCAN_RESULT:
            addr_type, addr, adv_type, rssi, adv_data = data
            if adv_type == _ADV_IND:
                type_list = decode_services(adv_data)
                if _ENV_SENSE_UUID in type_list:
                    # Found a potential device, remember it.
                    name = decode_name(adv_data) or "?"
                    self._peripherals.append((addr_type, addr, name))

        elif event == _IRQ_SCAN_DONE:
            if self._scan_callback:
                self._scan_callback()

        elif event == _IRQ_PERIPHERAL_CONNECT:
            # Connect successful.
            conn_handle, addr_type, addr = data
            for peripheral in self._peripherals:
                if addr_type == peripheral[0] and addr == peripheral[1]:
                    self._conn_handle = conn_handle
                    self._addr_type, self._addr = addr_type, addr
                    self._ble.gattc_discover_services(self._conn_handle)
                    break

        elif event == _IRQ_GATTC_SERVICE_RESULT:
            # Connected device returned a service.
            conn_handle, start_handle, end_handle, uuid = data
            if conn_handle == self._conn_handle and uuid == _ENV_SENSE_UUID:
                self._start_handle, self._end_handle = start_handle, end_handle

        elif event == _IRQ_GATTC_SERVICE_DONE:
            # Service query complete.
            if self._start_handle and self._end_handle:
                self._ble.gattc_discover_characteristics(
                    self._conn_handle, self._start_handle, self._end_handle
                )

        elif event == _IRQ_GATTC_CHARACTERISTIC_RESULT:
            # Connected device returned a characteristic.
            conn_handle, def_handle, value_handle, properties, uuid = data
            if conn_handle == self._conn_handle and uuid == _TEMP_UUID:
                self._value_handle = value_handle

        elif event == _IRQ_GATTC_READ_RESULT:
            # A read completed successfully.
            conn_handle, value_handle, char_data = data
            if conn_handle == self._conn_handle and value_handle == self._value_handle:
                self._update_value(char_data)
                if self._read_callback:
                    self._read_callback(self._value)
                    self._read_callback = None

    def scan(self, callback=None):
        self._peripherals = []
        self._scan_callback = callback
        self._ble.gap_scan(2000, 30000, 30000)

    def connect(self, addr_type=None, addr=None, callback=None):
        self._addr_type = addr_type
        self._addr = addr
        self._conn_callback = callback
        self._ble.gap_connect(self._addr_type, self._addr)

    def read(self, callback):
        if not self.is_connected():
            return
        self._read_callback = callback
        self._ble.gattc_read(self._conn_handle, self._value_handle)

    def _update_value(self, data):
        try:
            self._value = struct.unpack("<h", data)[0] / 100
        except OSError as error:
            print(error)

    def value(self):
        return self._value

def sleep_ms_flash_led(flash_count, delay_ms):
    led = Pin('LED', Pin.OUT)
    led.off()
    while delay_ms > 0:
        for _ in range(flash_count):
            led.on()
            time.sleep_ms(100)
            led.off()
            time.sleep_ms(100)
            delay_ms -= 200
        time.sleep_ms(1000)
        delay_ms -= 1000

def print_temp(result):
    print("Temperature: %.2f°C" % result)

def demo(ble, central):
    central.scan()
    while not central._peripherals:
        time.sleep_ms(100)
        
    print("Scanning done. Found", len(central._peripherals), "peripherals.")

    # Connect to each found peripheral
    for peripheral in central._peripherals:
        print("Connecting to:", peripheral[2])
        central.connect(addr_type=peripheral[0], addr=peripheral[1])
        
        while not central.is_connected():
            time.sleep_ms(100)
        
        print("Connected to:", peripheral[2])

        # Explicitly issue reads
        while central.is_connected():
            central.read(callback=print_temp)
            sleep_ms_flash_led(2, 2000)

        print("Disconnected from:", peripheral[2])

if __name__ == "__main__":
    ble = bluetooth.BLE()
    central = BLETemperatureCentral(ble)
    while True:
        print("hello")
        demo(ble, central)
        sleep_ms_flash_led(central, 1, 100)

