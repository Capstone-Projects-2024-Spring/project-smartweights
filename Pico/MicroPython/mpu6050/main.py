import bluetooth
import struct
import time
import machine
from ble_advertising import advertising_payload
from micropython import const
from machine import Pin
from mpuData import mpuData

_IRQ_CENTRAL_CONNECT = const(1)
_IRQ_CENTRAL_DISCONNECT = const(2)
_IRQ_GATTS_INDICATE_DONE = const(20)

_FLAG_READ = const(0x0002)
_FLAG_NOTIFY = const(0x0010)
_FLAG_INDICATE = const(0x0020)

# custom bluetooth service for acceleration sensing
_ACCEL_SENSE_UUID = bluetooth.UUID(0x4A40)

# custom bluetooth service for gyro sensing
_GYRO_SENSE_UUID = bluetooth.UUID(0x4A50)

# custom bluetooth characteristics for x, y, and z axes
_X_AXIS_CHAR = (
    bluetooth.UUID(0x4A41),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)

_Y_AXIS_CHAR = (
    bluetooth.UUID(0x4A42),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)

_Z_AXIS_CHAR = (
    bluetooth.UUID(0x4A43),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)

_ACCEL_SENSE_SERVICE = (
    _ACCEL_SENSE_UUID,
    (_X_AXIS_CHAR, _Y_AXIS_CHAR, _Z_AXIS_CHAR),
)


_X_GYRO_CHAR = (
    bluetooth.UUID(0x4A51),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)

_Y_GYRO_CHAR = (
    bluetooth.UUID(0x4A52),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)
_Z_GYRO_CHAR = (
    bluetooth.UUID(0x4A53),
    _FLAG_READ | _FLAG_NOTIFY | _FLAG_INDICATE,
)

_GYRO_SENSE_SERVICE = (
    _GYRO_SENSE_UUID,
    (_X_GYRO_CHAR, _Y_GYRO_CHAR, _Z_GYRO_CHAR),
)


class BLEAcceleration:
    def __init__(self, ble, id):
        self._mpu6050 = mpuData("MPU6050-1")
        #change ID depending on the device
        self._ble = ble
        self._ble.active(True)
        self._ble.irq(self._irq)
        ((self._handle_ax, self._handle_ay, self._handle_az), (self._handle_gx, self._handle_gy, self._handle_gz)) = self._ble.gatts_register_services((_ACCEL_SENSE_SERVICE,_GYRO_SENSE_SERVICE))
        self._connections = set()
        print('%s' % self._mpu6050.id)
        self._payload = advertising_payload(
            name=id, services=[_ACCEL_SENSE_UUID, _GYRO_SENSE_UUID]
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
            
    def update_acceleration(self, notify=False, indicate=False):
        mpu6050 = self._mpu6050
        accelData = mpu6050.get_accel_data()
        gyroData = mpu6050.get_gyro_data()
        gx,gy,gz = gyroData[0],gyroData[1],gyroData[2]
        ax,ay,az = accelData[0],accelData[1],accelData[2]
        ax, ay, az = int(ax *100), int(ay*100), int(az*100)
        gx, gy, gz = int(gx), int(gy), int(gz)
        
        print('--------------------')
        print(accelData[0], accelData[1], accelData[2])
        print("Accel - X: {}, Y: {}, Z: {}".format(ax,ay,az))
        print('--------------------')
        print(gyroData[0], gyroData[1], gyroData[2])
        print("Gyro - X: {}, Y: {}, Z: {}".format(gx,gy,gz))
        
        
        self._ble.gatts_write(self._handle_ax, struct.pack("<h", ax))
        self._ble.gatts_write(self._handle_ay, struct.pack("<h", ay))
        self._ble.gatts_write(self._handle_az, struct.pack("<h", az))
        self._ble.gatts_write(self._handle_gx, struct.pack("<h", gx))
        self._ble.gatts_write(self._handle_gy, struct.pack("<h", gy))
        self._ble.gatts_write(self._handle_gz, struct.pack("<h", gz))
        if notify or indicate:
            for conn_handle in self._connections:
                if notify:
                    # Notify connected centrals.
                    self._ble.gatts_notify(conn_handle, self._handle_ax)
                    self._ble.gatts_notify(conn_handle, self._handle_ay)
                    self._ble.gatts_notify(conn_handle, self._handle_az)
                    self._ble.gatts_notify(conn_handle, self._handle_gx)
                    self._ble.gatts_notify(conn_handle, self._handle_gy)
                    self._ble.gatts_notify(conn_handle, self._handle_gz)
                    print("i am connected and notifying")
                    
                if indicate:
                    # Indicate connected centrals.
                    self._ble.gatts_indicate(conn_handle, self._handle_ax)
                    self._ble.gatts_indicate(conn_handle, self._handle_ay)
                    self._ble.gatts_indicate(conn_handle, self._handle_az)
                    self._ble.gatts_indicate(conn_handle, self._handle_gx)
                    self._ble.gatts_indicate(conn_handle, self._handle_gy)
                    self._ble.gatts_indicate(conn_handle, self._handle_gz)
                    print("i am connected")
                
    
    def _advertise(self, interval_us=500000):
        self._ble.gap_advertise(interval_us, adv_data=self._payload)
        
def demo():
    ble = bluetooth.BLE()
    accel = BLEAcceleration(ble, id="MPU6050-1")
    #change ID depending on the device
    counter = 0
    led = Pin('LED', Pin.OUT)
    while True:
        if counter % 10 == 0:
            accel.update_acceleration(notify=True, indicate=False)
        led.toggle()
        time.sleep_ms(10)
        counter += 1
        
if __name__ == "__main__":
    demo()

