##another test code for the mpu6050, this uses a different library.
## uses mpu6050.py

from machine import Pin, I2C
import time
import MPU6050

# Set up the I2C interface
#i2c = machine.I2C(1, sda=machine.Pin(0), scl=machine.Pin(1))

i2c = machine.I2C(0, sda=Pin(0), scl=Pin(1), freq=400000)

# Set up the MPU6050 class 
mpu = MPU6050.MPU6050(i2c)

# wake up the MPU6050 from sleep
mpu.wake()

# continuously print the data
while True:
    gyro = mpu.read_gyro_data()
    accel = mpu.read_accel_data()
    print("Gyro: " + str(gyro) + ", Accel: " + str(accel),"        ",end="\r")
    time.sleep(0.3)


