# This will transmits the accel data

import bluetooth
import random
import struct
import time
import machine
import ubinascii
from ble_advertising import advertising_payload
from micropython import const
from machine import Pin

_IRQ_CENTRAL_CONNECT = const(1)
_IRQ_CENTRAL_DISCONNECT = const(2)
_IRQ_GATTS_INDICATE_DONE = const(20)

_FLAG_READ = const(0x0002)
_FLAG_NOTIFY = const(0x0010)
_FLAG_INDICATE = const(0x0020)


#0x2713 = acceleration m/s^2
_ACCEL_UUID = bluetooth.UUID(0x2713)
# org.bluetooth.characteristic.temperature
#0x183E - Physical Activity Monitor Service
_ACCEL_DATA = (
    bluetooth.UUID(0x183E),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)
_ACCEL_SERVICE = (
    _ACCEL_UUID,
    (_ACCEL_DATA,),
)



# Bluetooth class to send accel data

class BLEaccel:
    def __init__(self, ble, name=""):
        #need to get accel data
        #self._sensor_temp = machine.ADC(4)
        
        self._ble = ble
        self._ble.active(True)
        self._ble.irq(self._irq)
        ((self._handle,),) = self._ble.gatts_register_services((_ACCEL_SERVICE,))
        self._connections = set()
        if len(name) == 0:
            name = 'Pico %s' % ubinascii.hexlify(self._ble.config('mac')[1],':').decode().upper()
        print('Sensor name %s' % name)
        self._payload = advertising_payload(
            name=name, services=[_ACCEL_UUID]
        )
        self._advertise()

    def _irq(self, event, data):
        # Track connections so we can send notifications.
        if event == _IRQ_CENTRAL_CONNECT:
            conn_handle, _, _ = data
            self._connections.add(conn_handle)
        elif event == _IRQ_CENTRAL_DISCONNECT:
            conn_handle, _, _ = data
            self._connections.remove(conn_handle)
            # Start advertising again to allow a new connection.
            self._advertise()
        elif event == _IRQ_GATTS_INDICATE_DONE:
            conn_handle, value_handle, status = data


    # need to change this to send accel data
    
    
    def update_accel(self, notify=False, indicate=False):
        num = self._get_accel()
        print(num)
        
        if notify or indicate:
            for conn_handle in self._connections:
                if notify:
                    # Notify connected centrals.
                    self._ble.gatts_notify(conn_handle, self._handle)
                if indicate:
                    # Indicate connected centrals.
                    self._ble.gatts_indicate(conn_handle, self._handle)

    

    
    # def update_temperature(self, notify=False, indicate=False):
    #     # Write the local value, ready for a central to read.
    #     temp_deg_c = self._get_temp()
    #     print("write temp %.2f degc" % temp_deg_c);
    #     self._ble.gatts_write(self._handle, struct.pack("<h", int(temp_deg_c * 100)))
    #     if notify or indicate:
    #         for conn_handle in self._connections:
    #             if notify:
    #                 # Notify connected centrals.
    #                 self._ble.gatts_notify(conn_handle, self._handle)
    #             if indicate:
    #                 # Indicate connected centrals.
    #                 self._ble.gatts_indicate(conn_handle, self._handle)






    def _advertise(self, interval_us=500000):
        self._ble.gap_advertise(interval_us, adv_data=self._payload)


    # This is not needed
    
    # ref https://github.com/raspberrypi/pico-micropython-examples/blob/master/adc/temperature.py
    # def _get_temp(self):
    #     conversion_factor = 3.3 / (65535)
    #     reading = self._sensor_temp.read_u16() * conversion_factor
        
    #     # The temperature sensor measures the Vbe voltage of a biased bipolar diode, connected to the fifth ADC channel
    #     # Typically, Vbe = 0.706V at 27 degrees C, with a slope of -1.721mV (0.001721) per degree. 
    #     return 27 - (reading - 0.706) / 0.001721
    
    
    #get the accelerations of x,y,z from the accelerometer
    def _get_accel(self):
        
        return 10 
        
    



def demo():
    ble = bluetooth.BLE()
    temp = BLEaccel(ble)
    counter = 0
    led = Pin('LED', Pin.OUT)
    while True:
        if counter % 10 == 0:
            temp.update_accel(notify=True, indicate=False)
        led.toggle()
        time.sleep_ms(1000)
        counter += 1

if __name__ == "__main__":
    demo()
