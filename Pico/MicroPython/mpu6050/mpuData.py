from machine import Pin, I2C
import MPU6050
from time import sleep
import machine

i2c = machine.I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)

class mpuData:
    def __init__(self, id) -> None:
        
        self.id = id
        self.mpu = MPU6050.MPU6050(i2c)
        self.mpu.wake()
        self.mpu.write_gyro_range(3) # ±2000°/s

        
    ''' accelerometer range is set to ±2g, it means that the accelerometer of your MPU6050 sensor can
    measure accelerations between -2 and +2 g's, where 1 g is approximately 9.81 m/s², the acceleration
    due to gravity on Earth. The raw data from the accelerometer is in a digital format that needs 
    to be converted to a physical unit (g). The conversion factor for a ±2g range is 16384.0. 
    This means that if you read a raw value from the accelerometer, you would divide it by 16384.0 
    to get the acceleration in g's. For example, if the raw data is 16384, the acceleration would be 16384 / 16384.0 = 1g.y.
    '''
    def get_accel_data(self) -> tuple:
        accel = self.mpu.read_accel_data()
        return accel #(x, y, z)
        #unit of measurement is g's
    
    
    '''If your modifier is 131, it means that the gyroscope range of your MPU6050 sensor is set to ±250 degrees per second.
    The modifier is used to convert the raw data from the gyroscope to actual angular velocity in degrees per second. 
    The raw data is divided by the modifier to get the angular velocity.
    Here's how the modifiers correspond to the gyroscope ranges:
        For a range of ±250°/s, the modifier is 131.0
        For a range of ±500°/s, the modifier is 65.5
        For a range of ±1000°/s, the modifier is 32.8
        For a range of ±2000°/s, the modifier is 16.4
    So, if your modifier is 131, you're using the ±250°/s range. 
    This means that the gyroscope can measure angular velocities between -250 and +250 degrees per second.
    When you read the raw data from the gyroscope, you divide it by 131 to get the angular velocity in degrees per second.'''
    
    def get_gyro_data(self) -> tuple:
        gyro = self.mpu.read_gyro_data()
        return gyro #(x, y, z)
        #unit of measurement is degrees per second

def demo():
    mpu6050 = mpuData("id")
    while True:
        print(mpu6050.get_accel_data())
        sleep(.5)

if __name__ == "__main__":
    demo()

