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
        
    def get_accel_data(self) -> tuple:
        accel = self.mpu.read_accel_data()
        return accel #(x, y, z)
    
    def get_gyro_data(self) -> tuple:
        gyro = self.mpu.read_gyro_data()
        return gyro #(x, y, z)
    
    def hello(self):
        print("Hello")

def demo():
    mpu6050 = mpuData("id")
    while True:
        print(mpu6050.get_accel_data())
        sleep(.5)

if __name__ == "__main__":
    demo()

