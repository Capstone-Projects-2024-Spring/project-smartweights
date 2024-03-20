from machine import Pin, I2C
import time
import ustruct
from micropython import const

# Constants
ADXL345_ADDRESS = const(0x53) # Address for accelerometer on I2C bus
ADXL345_POWER_CTL = const(0x2D) # Address for power-saving features control
ADXL345_DATA_FORMAT = const(0x31) # Address for data format control
ADXL345_DATAX0 = const(0x32) # Address for X-Axis Data 0

# Initialize I2C
i2c = I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)

class ADXL345:
    def __init__(self, id):
        self.id = id
        self.x = 0
        self.y = 0
        self.z = 0
        self.init_adxl345()
    
    def init_adxl345(self):
        i2c.writeto_mem(ADXL345_ADDRESS, ADXL345_POWER_CTL, bytearray([0x08])) # Set bit 3 to 1 to enable measurement mode
        i2c.writeto_mem(ADXL345_ADDRESS, ADXL345_DATA_FORMAT, bytearray([0x0B])) # Set data format to full resolution, +/- 16g
    
    # Read acceleration data
    def read_accel_data(self):
        data = i2c.readfrom_mem(ADXL345_ADDRESS, ADXL345_DATAX0, 6)
        self.x, self.y, self.z = ustruct.unpack('<3h', data)
        return self.x, self.y, self.z
        
    def get_accel_data(self):
        return self.x, self.y, self.z
        
    def run(self):
        while True:
            self.read_accel_data()
            print('--------------------')
            print(self.x, self.y, self.z)
            print("X: {}, Y: {}, Z: {}".format(self.x / 256, self.y / 256, self.z / 256))
            time.sleep(0.5)
        
if __name__ == "__main__":
    adxl345_sensor = ADXL345("1")
    adxl345_sensor.run()