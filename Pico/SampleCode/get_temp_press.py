# -*- coding: utf-8 -*
from BMP3XX import *

'''
  # i2c_addr = 0x76: pin SDO is low
  # i2c_addr = 0x77: pin SDO is high
  # Note: Both the BMP390L and gravity version of the BMP388 sensor have pulled the SDO pin high by default, the address is 0x77; but the breakout version does not pull 
  #       the SDO high, and the I2C address is 0x76.
  # The following I2C and SPI communications support both BMP388 and BMP390L
'''
sensor = BMP3XX_I2C(i2c_addr = 0x77,bus = 1)
# sensor = BMP3XX_SPI(cs=8, bus=0, dev=0, speed=8000000)

def setup():
  while (sensor.begin() == False):
    print ('Please check that the device is properly connected')
    time.sleep(3)
  print("sensor begin successfully!!!")

  '''
    # 6 commonly used sampling modes that allows users to configure easily, mode: 
    #      ULTRA_LOW_PRECISION, Ultra-low precision, suitable for monitoring weather (lowest power consumption), the power is mandatory mode.
    #      LOW_PRECISION,Low precision, suitable for random detection, power is normal mode
    #      NORMAL_PRECISION1, Normal precision 1, suitable for dynamic detection on handheld devices (e.g on mobile phones), power is normal mode
    #      NORMAL_PRECISION2, Normal precision 2, suitable for drones, power is normal mode
    #      HIGH_PRECISION, High precision, suitable for low-power handled devices (e.g mobile phones), power is normal mode
    #      ULTRA_PRECISION, Ultra-high precision, suitable for indoor navigation, its acquisition rate will be extremely low, and the acquisition cycle is 1000 ms.
  '''
  while(sensor.set_common_sampling_mode(ULTRA_PRECISION) == False):
    print ('Set samping mode fail, retrying...')
    time.sleep(3)

  '''
    # Calibrate the sensor according to the current altitude
    # In this example, we use an altitude of 540 meters in Wenjiang District of Chengdu (China). Please change to the local altitude when using it.
    # If this interface is not called, the measurement data will not eliminate the absolute difference
    # Notice: This interface is only valid for the first call
    # If you do not need to eliminate the absolute difference of measurement, please comment the following line
  '''
  if( sensor.calibrated_absolute_difference(540.0) == True ):
    print("Absolute difference base value set successfully!")

def loop():
  # Read currently measured temperature date directly, unit: °C
  print("temperature : %.2f C" %(sensor.get_temperature))

  # Directly read the currently measured pressure data, unit: pa
  print("Pressure : %.2f Pa" %(sensor.get_pressure))

  # Read altitude, unit: m
  print("Altitude : %.2f m" %(sensor.get_altitude))

  print("\r\b\r\b\r\b\r\b\r")
  time.sleep(0.5)

if __name__ == "__main__":
  setup()
  while True:
    loop()


