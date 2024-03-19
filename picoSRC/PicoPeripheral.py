# This is the file that we will use for the project and this will transmits the accel data

import bluetooth
import random
import struct
import time
import machine
import ubinascii
from ble_advertising import advertising_payload
from micropython import const
from machine import Pin
import MPU6050

_IRQ_CENTRAL_CONNECT = const(1)
_IRQ_CENTRAL_DISCONNECT = const(2)
_IRQ_GATTS_INDICATE_DONE = const(20)

_FLAG_READ = const(0x0002)
_FLAG_NOTIFY = const(0x0010)
_FLAG_INDICATE = const(0x0020)


#broadcasting a specific UUID and service

#0x183E - Physical Activity Monitor Service
_PHYSICAL_UUID = bluetooth.UUID(0x183E)

#0x2713 = acceleration m/s^2
_ACCEL_DATA = (
    bluetooth.UUID(0x2713),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)
_ACCEL_SERVICE = (
    _PHYSICAL_UUID,
    (_ACCEL_DATA,),
)

##for sensor
i2c = machine.I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)
mpu = MPU6050.MPU6050(i2c)
mpu.wake()


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
            name=name, services=[_PHYSICAL_UUID]
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


    #updates the accel that is read
    #need to implement the accel data
    
    def update_data(self, notify=False, indicate=False):
        data = self._get_data()  #data = [(x,y,z),(a,b,c)] - tuple data for gyro and accel

        # Initialize an empty byte array to store the packed data
        packed_data = bytearray()

        # Iterate over each tuple in the data
        for xyzabc in data:
            # Pack each set of (x, y, z) and (a, b, c) individually and append to packed_data
            packed_data.extend(struct.pack("<fff", *xyzabc[:3]))  # Pack the gyro
            packed_data.extend(struct.pack("<fff", *xyzabc[3:]))  # Pack the accel

        # Write the packed data to the GATT characteristic
        self._ble.gatts_write(self._handle, packed_data)
        
        if notify or indicate:
            for conn_handle in self._connections:
                if notify:
                    # Notify connected centrals.
                    self._ble.gatts_notify(conn_handle, self._handle)
                if indicate:
                    # Indicate connected centrals.
                    self._ble.gatts_indicate(conn_handle, self._handle)

    



    def _advertise(self, interval_us=500000):
        self._ble.gap_advertise(interval_us, adv_data=self._payload)


    #get the data from the MPU
    def _get_data(self):
        
        data = []
        gyro = mpu.read_gyro_data()
        accel = mpu.read_accel_data()
        print("Gyro: " + str(gyro) + ", Accel: " + str(accel),"        ",end="\r")
        data.append(gyro)
        data.append(accel)
            
        return data
    

    
    



def demo():
    ble = bluetooth.BLE()
    temp = BLEaccel(ble)
    counter = 0
    led = Pin('LED', Pin.OUT)
    while True:
        if counter % 10 == 0:
            temp.update_data(notify=True, indicate=False)
        led.toggle()
        time.sleep_ms(1000)
        counter += 1

if __name__ == "__main__":
    demo()
