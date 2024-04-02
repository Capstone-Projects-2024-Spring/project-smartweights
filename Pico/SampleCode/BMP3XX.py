# -*- coding: utf-8 -*

import utime
from machine import I2C,Pin






## I2C communication address when SDO is grounded
BMP3XX_I2C_ADDR_SDO_GND = 0x76
## I2C communication address when SDO is connected to power
BMP3XX_I2C_ADDR_SDO_VDD = 0x77

## BMP388 chip version
BMP388_CHIP_ID = 0x50
## BMP390L chip version
BMP390L_CHIP_ID = 0x60

# BMP3XX register address
## The “CHIP_ID” register contains the chip identification code.
BMP3XX_CHIP_ID = 0x00
## The “Rev_ID” register contains the mask revision of the ASIC.
BMP3XX_REV_ID = 0x01
## Sensor Error conditions are reported in the “ERR_REG” register.
BMP3XX_ERR_REG = 0x02
## The Sensor Status Flags are stored in the “STATUS” register.
BMP3XX_STATUS = 0x03
## The 24Bit pressure data is split and stored in three consecutive registers.
BMP3XX_P_DATA_PA = 0x04
## The 24Bit temperature data is split and stored in three consecutive registered.
BMP3XX_T_DATA_C = 0x07
## The 24Bit sensor time is split and stored in three consecutive registers.
BMP3XX_TIME = 0x0C
## The “EVENT” register contains the sensor status flags.
BMP3XX_EVENT = 0x10
## The “INT_STATUS” register shows interrupt status and is cleared after reading.
BMP3XX_INT_STATUS = 0x11
## The FIFO byte counter indicates the current fill level of the FIFO buffer.
BMP3XX_FIFO_LENGTH = 0x12
## The “FIFO_DATA” is the data output register.
BMP3XX_FIFO_DATA = 0x14
## The FIFO Watermark size is 9 Bit and therefore written to the FIFO_WTM_0 and FIFO_WTM_1 registers.
BMP3XX_FIFO_WTM_0 = 0x15
## The FIFO Watermark size is 9 Bit and therefore written to the FIFO_WTM_0 and FIFO_WTM_1 registers.
BMP3XX_FIFO_WTM_1 = 0x16
## The “FIFO_CONFIG_1” register contains the FIFO frame content configuration.
BMP3XX_FIFO_CONF_1 = 0x17
## The “FIFO_CONFIG_2” register extends the FIFO_CONFIG_1 register.
BMP3XX_FIFO_CONF_2 = 0x18
## Interrupt configuration can be set in the “INT_CTRL” register.
BMP3XX_INT_CTRL = 0x19
## The “IF_CONF” register controls the serial interface settings.
BMP3XX_IF_CONF = 0x1A
## The “PWR_CTRL” register enables or disables pressure and temperature measurement.
BMP3XX_PWR_CTRL = 0x1B
## The “OSR” register controls the oversampling settings for pressure and temperature measurements.
BMP3XX_OSR = 0x1C
## The “ODR” register set the configuration of the output data rates by means of setting the subdivision/subsampling.
BMP3XX_ODR = 0x1D
## The “CONFIG” register controls the IIR filter coefficients
BMP3XX_IIR_CONFIG = 0x1F
## 0x31-0x45 is calibration data
BMP3XX_CALIB_DATA = 0x31
## Command register, can soft reset and clear all FIFO data
BMP3XX_CMD = 0x7E

# Sensor configuration
## Sleep mode: It will be in sleep mode by default after power-on reset. In this mode, no measurement is performed and power consumption is minimal. 
##             All registers are accessible for reading the chip ID and compensation coefficient.
SLEEP_MODE  = 0x00
## Forced mode: In this mode, the sensor will take a single measurement according to the selected measurement and filtering options. After the
##              measurement is completed, the sensor will return to sleep mode, and the measurement result can be obtained in the register.
FORCED_MODE = 0x10
## Normal mode: Continuously loop between the measurement period and the standby period. The output data rates are related to the ODR mode setting.
NORMAL_MODE = 0x30

## pressure oversampling settings
BMP3XX_PRESS_OSR_SETTINGS = (0x00, 0x01, 0x02, 0x03, 0x04, 0x05)
## temperature oversampling settings
BMP3XX_TEMP_OSR_SETTINGS = (0x00, 0x08, 0x10, 0x18, 0x20, 0x28)

## Filter coefficient is 0 ->Bypass mode
BMP3XX_IIR_CONFIG_COEF_0   = 0x00
## Filter coefficient is 1
BMP3XX_IIR_CONFIG_COEF_1   = 0x02
## Filter coefficient is 3
BMP3XX_IIR_CONFIG_COEF_3   = 0x04
## Filter coefficient is 7
BMP3XX_IIR_CONFIG_COEF_7   = 0x06
## Filter coefficient is 15
BMP3XX_IIR_CONFIG_COEF_15  = 0x08
## Filter coefficient is 31
BMP3XX_IIR_CONFIG_COEF_31  = 0x0A
## Filter coefficient is 63
BMP3XX_IIR_CONFIG_COEF_63  = 0x0C
## Filter coefficient is 127
BMP3XX_IIR_CONFIG_COEF_127 = 0x0E

## Prescale:1; ODR 200Hz; Sampling period:5 ms
BMP3XX_ODR_200_HZ    = 0x00
## Prescale:2; Sampling period:10 ms
BMP3XX_ODR_100_HZ    = 0x01
## Prescale:4; Sampling period:20 ms
BMP3XX_ODR_50_HZ     = 0x02
## Prescale:8; Sampling period:40 ms
BMP3XX_ODR_25_HZ     = 0x03
## Prescale:16; Sampling period:80 ms
BMP3XX_ODR_12P5_HZ   = 0x04
## Prescale:32; Sampling period:160 ms
BMP3XX_ODR_6P25_HZ   = 0x05
## Prescale:64; Sampling period:320 ms
BMP3XX_ODR_3P1_HZ    = 0x06
## Prescale:127; Sampling period:640 ms
BMP3XX_ODR_1P5_HZ    = 0x07
## Prescale:256; Sampling period:1.280 s
BMP3XX_ODR_0P78_HZ   = 0x08
## Prescale:512; Sampling period:2.560 s
BMP3XX_ODR_0P39_HZ   = 0x09
## Prescale:1024 Sampling period:5.120 s
BMP3XX_ODR_0P2_HZ    = 0x0A
## Prescale:2048; Sampling period:10.24 s
BMP3XX_ODR_0P1_HZ    = 0x0B
## Prescale:4096; Sampling period:20.48 s
BMP3XX_ODR_0P05_HZ   = 0x0C
## Prescale:8192; Sampling period:40.96 s
BMP3XX_ODR_0P02_HZ   = 0x0D
## Prescale:16384; Sampling period:81.92 s
BMP3XX_ODR_0P01_HZ   = 0x0E
## Prescale:32768; Sampling period:163.84 s
BMP3XX_ODR_0P006_HZ  = 0x0F
## Prescale:65536; Sampling period:327.68 s
BMP3XX_ODR_0P003_HZ  = 0x10
## Prescale:131072; ODR 25/16384Hz; Sampling period:655.36 s
BMP3XX_ODR_0P0015_HZ = 0x11

# 6 commonly used sampling modes
# Ultra-low precision, suitable for monitoring weather (lowest power consumption), the power is mandatory mode.
ULTRA_LOW_PRECISION = 0
## Low precision, suitable for casual detection, power is normal mode
LOW_PRECISION = 1
## Normal precision 1, suitable for dynamic detection on handheld devices (e.g on mobile phones), power is normal mode
NORMAL_PRECISION1 = 2
## Normal precision 2, suitable for drones, power is normal mode
NORMAL_PRECISION2 = 3
## High precision, suitable for low-power handled devices (e.g mobile phones), power is normal mode
HIGH_PRECISION = 4
## Ultra-high precision, suitable for indoor navigation, its acquisition rate will be extremely low, and the acquisition cycle is 1000 ms.
ULTRA_PRECISION = 5

# CMD(0x7E) Rigister command
## reserved. No command.
BMP3XX_CMD_NOP = 0x00
## Clears all data in the FIFO, does not change FIFO_CONFIG registers.
BMP3XX_CMD_FIFO_FLUSH = 0xB0
## Triggers a reset, all user configuration settings are overwritten with their default state.
BMP3XX_CMD_RESET = 0xB6

# FIFO Header
## FIFO temperature pressure header frame
BMP3_FIFO_TEMP_PRESS_FRAME = 0x94
## FIFO temperature header frame
BMP3_FIFO_TEMP_FRAME = 0x90
## FIFO pressure header frame
BMP3_FIFO_PRESS_FRAME = 0x84
## FIFO time header frame
BMP3_FIFO_TIME_FRAME = 0xA0
## FIFO configuration change header frame
BMP3_FIFO_CONFIG_CHANGE = 0x48
## FIFO error header frame
BMP3_FIFO_ERROR_FRAME = 0x44

# Immediate data
## The byte length of each data in a frame of FIFO data is 3
BMP3XX_FIFO_DATA_FRAME_LENGTH = 7
## Standard sea level pressure, unit: pa
STANDARD_SEA_LEVEL_PRESSURE_PA = 101325


class BMP3XX(object):
    '''!
      @brief define BMP3XX base class
      @details for driving the pressure sensor
    '''

    def __init__(self):
        '''!
          @brief Module init
        '''
        # Sea level pressure in Pa.
        self.sea_level_pressure = STANDARD_SEA_LEVEL_PRESSURE_PA

    def begin(self):
        '''!
          @brief Initialize sensor
          @return  return initialization status
          @retval True indicate initialization succeed
          @retval False indicate initialization failed
        '''
        ret = True
        chip_id = self._read_reg(BMP3XX_CHIP_ID, 1)
        print(chip_id[0])
        if chip_id[0] not in (BMP388_CHIP_ID, BMP390L_CHIP_ID):
            ret = False
        self._get_coefficients()
        self.reset()
        return ret

    @property
    def get_pressure(self):
        '''!
          @brief Get pressure measurement value from register, working range (300‒1250 hPa)
          @return Return pressure measurements, unit: Pa
          @attention If the reference value is provided before, the absolute value of the current 
          @n         position pressure is calculated according to the calibrated sea level atmospheric pressure
        '''
        adc_p, adc_t = self._get_reg_temp_press_data()

        return self._compensate_data(adc_p, adc_t)[0]

    @property
    def get_temperature(self):
        '''!
          @brief Get pressure measurement value from register, working range (-40 ‒ +85 °C)
          @return Return temperature measurements, unit: °C
        '''
        adc_p, adc_t = self._get_reg_temp_press_data()
        return self._compensate_data(adc_p, adc_t)[1]

    def calibrated_absolute_difference(self, altitude):
        '''!
          @brief Take the given current location altitude as the reference value 
          @n     to eliminate the absolute difference for subsequent pressure and altitude data
          @param altitude Altitude in current position
          @return Pass the benchmark value successfully will return ture, if failed it will return false
        '''
        # The altitude in meters based on the currently set sea level pressure.
        ret = False
        if STANDARD_SEA_LEVEL_PRESSURE_PA == self.sea_level_pressure:
            self.sea_level_pressure = (self.get_pressure / pow(1.0 - (altitude / 44307.7), 5.255302))
            ret = True
        return ret

    @property
    def get_altitude(self):
        '''!
          @brief Calculate the altitude based on the atmospheric pressure measured by the sensor
          @return Return altitude, unit: m
          @attention If the reference value is provided before, the absolute value of the current 
          @n         position pressure is calculated according to the calibrated sea level atmospheric pressure
        '''
        # see https://www.weather.gov/media/epz/wxcalc/pressureAltitude.pdf
        return 44307.7 * (1 - (self.get_pressure / STANDARD_SEA_LEVEL_PRESSURE_PA) ** 0.190284)

    def set_power_mode(self, mode):
        '''!
          @brief Configure measurement mode and power mode 
          @param mode The measurement mode and power mode that need to be set:
          @n  SLEEP_MODE(Sleep mode): It will be in sleep mode by default after power-on reset. In this mode,no 
          @n                          measurement is performed and power consumption is minimal. All registers 
          @n                          are accessible for reading the chip ID and compensation coefficient.
          @n  FORCED_MODE(Forced mode): In this mode, the sensor will take a single measurement according to the selected 
          @n                            measurement and filtering options. After the measurement is completed, the sensor 
          @n                            will return to sleep mode, and the measurement result can be obtained in the register.
          @n  NORMAL_MODE(Normal mode): Continuously loop between the measurement period and the standby period. 
          @n                            The output data rates are related to the ODR mode setting.
        '''
        temp = self._read_reg(BMP3XX_PWR_CTRL, 1)[0]
        if (mode | 0x03) == temp:
            print("Same configuration as before!")
        else:
            if mode != SLEEP_MODE:
                self._write_reg(BMP3XX_PWR_CTRL, (SLEEP_MODE & 0x30) | 0x03)
                utime.sleep(0.02)
            self._write_reg(BMP3XX_PWR_CTRL, (mode & 0x30) | 0x03)
            utime.sleep(0.02)

    def enable_fifo(self, mode):
        '''!
          @brief Enbale or disable FIFO
          @param mode: 
          @n       True: Enable FIFO
          @n       False: Disable FIFO
        '''
        if mode:
            # Enable and initialize FIFO configuration
            self._write_reg(BMP3XX_FIFO_CONF_1, 0x1D)
            self._write_reg(BMP3XX_FIFO_CONF_2, 0x0C)
        else:
            # 关闭FIFO。
            self._write_reg(BMP3XX_FIFO_CONF_1, 0x1C)
            self._write_reg(BMP3XX_FIFO_CONF_2, 0x0C)
        utime.sleep(0.02)

    def set_oversampling(self, press_osr_set, temp_osr_set):
        '''!
          @brief Configure the oversampling when measuring pressure and temperature (OSR:over-sampling register)
          @details Oversampling mode of pressure and temperature measurement need to be set
          @param press_osr_set 6 pressure oversampling mode:
          @n       BMP3XX_PRESS_OSR_SETTINGS[0], Pressure sampling×1, 16 bit / 2.64 Pa (Recommend temperature oversampling×1)
          @n       BMP3XX_PRESS_OSR_SETTINGS[1], Pressure sampling×2, 16 bit / 2.64 Pa (Recommend temperature oversampling×1)
          @n       BMP3XX_PRESS_OSR_SETTINGS[2], Pressure sampling×4, 18 bit / 0.66 Pa (Recommend temperature oversampling×1)
          @n       BMP3XX_PRESS_OSR_SETTINGS[3], Pressure sampling×8, 19 bit / 0.33 Pa (Recommend temperature oversampling×2)
          @n       BMP3XX_PRESS_OSR_SETTINGS[4], Pressure sampling×16, 20 bit / 0.17 Pa (Recommend temperature oversampling×2)
          @n       BMP3XX_PRESS_OSR_SETTINGS[5], Pressure sampling×32, 21 bit / 0.085 Pa (Recommend temperature oversampling×2)
          @param temp_osr_set 6 temperature oversampling mode:
          @n       BMP3XX_TEMP_OSR_SETTINGS[0], Temperature sampling×1, 16 bit / 0.0050 °C
          @n       BMP3XX_TEMP_OSR_SETTINGS[1], Temperature sampling×2, 16 bit / 0.0025 °C
          @n       BMP3XX_TEMP_OSR_SETTINGS[2], Temperature sampling×4, 18 bit / 0.0012 °C
          @n       BMP3XX_TEMP_OSR_SETTINGS[3], Temperature sampling×8, 19 bit / 0.0006 °C
          @n       BMP3XX_TEMP_OSR_SETTINGS[4], Temperature sampling×16, 20 bit / 0.0003 °C
          @n       BMP3XX_TEMP_OSR_SETTINGS[5], Temperature sampling×32, 21 bit / 0.00015 °C
        '''
        self._write_reg(BMP3XX_OSR, (press_osr_set | temp_osr_set) & 0x3F)

    def filter_coefficient(self, iir_config_coef):
        '''!
          @brief IIR filter coefficient setting(IIR filtering)
          @param iir_config_coef Set IIR filter coefficient, configurable mode:
          @n       BMP3XX_IIR_CONFIG_COEF_0, BMP3XX_IIR_CONFIG_COEF_1, BMP3XX_IIR_CONFIG_COEF_3, 
          @n       BMP3XX_IIR_CONFIG_COEF_7, BMP3XX_IIR_CONFIG_COEF_15, BMP3XX_IIR_CONFIG_COEF_31, 
          @n       BMP3XX_IIR_CONFIG_COEF_63, BMP3XX_IIR_CONFIG_COEF_127
        '''
        # The IIR filter coefficient.
        self._write_reg(BMP3XX_IIR_CONFIG, iir_config_coef & 0x0E)

    def set_output_data_rates(self, odr_set):
        '''!
          @brief Set output data rate in subdivision/sub-sampling mode (ODR:output data rates)
          @param odr_set The output data rate needs to be set, configurable mode:
          @n       BMP3XX_ODR_200_HZ, BMP3XX_ODR_100_HZ, BMP3XX_ODR_50_HZ, BMP3XX_ODR_25_HZ, BMP3XX_ODR_12P5_HZ, 
          @n       BMP3XX_ODR_6P25_HZ, BMP3XX_ODR_3P1_HZ, BMP3XX_ODR_1P5_HZ, BMP3XX_ODR_0P78_HZ, BMP3XX_ODR_0P39_HZ, 
          @n       BMP3XX_ODR_0P2_HZ, BMP3XX_ODR_0P1_HZ, BMP3XX_ODR_0P05_HZ, BMP3XX_ODR_0P02_HZ, BMP3XX_ODR_0P01_HZ, 
          @n       BMP3XX_ODR_0P006_HZ, BMP3XX_ODR_0P003_HZ, BMP3XX_ODR_0P0015_HZ
          @return  return configuration results
          @retval True indicate configuration succeed
          @retval False indicate configuration failed and remains its original state
        '''
        # The IIR filter coefficient.
        ret = True
        self._write_reg(BMP3XX_ODR, odr_set & 0x1F)
        if (self._read_reg(BMP3XX_ERR_REG, 1)[0] & 0x04):
            print("Sensor configuration error detected!")
            ret = False
        return ret

    def _uint8_to_int(self,num):
        '''!
          @brief Convert the incoming uint8 type data to int type
          @param num Incoming uint8 type data
          @return data converted to int type
        '''
        if(num>127):
            num = num - 256
        return num

    def _uint16_to_int(self,num):
        '''!
          @brief Convert the incoming uint16 type data to int type
          @param num Incoming uint16 type data
          @return data converted to int type
        '''
        if(num>32767):
            num = num - 65536
        return num

    def set_common_sampling_mode(self, mode):
        '''!
          @brief 6 commonly used sampling modes that allows users to configure easily
          @param mode:
          @n       ULTRA_LOW_PRECISION, Ultra-low precision, suitable for monitoring weather (lowest power consumption), the power is mandatory mode.
          @n       LOW_PRECISION, Low precision, suitable for random detection, power is normal mode
          @n       NORMAL_PRECISION1, Normal precision 1, suitable for dynamic detection on handheld devices (e.g on mobile phones), power is normal mode
          @n       NORMAL_PRECISION2, Normal precision 2, suitable for drones, power is normal mode
          @n       HIGH_PRECISION, High precision, suitable for low-power handled devices (e.g mobile phones), power is normal mode
          @n       ULTRA_PRECISION, Ultra-high precision, suitable for indoor navigation, its acquisition rate will be extremely low, and the acquisition cycle is 1000 ms.
          @return  return configuration results
          @retval True indicate configuration succeed
          @retval False indicate configuration failed and remains its original state
        '''
        ret = True
        if mode == ULTRA_LOW_PRECISION:
            self.set_power_mode(FORCED_MODE)
            self.set_oversampling(BMP3XX_PRESS_OSR_SETTINGS[0], BMP3XX_TEMP_OSR_SETTINGS[0])
            self.filter_coefficient(BMP3XX_IIR_CONFIG_COEF_0)
            self.set_output_data_rates(BMP3XX_ODR_0P01_HZ)
        elif mode == LOW_PRECISION:
            self.set_power_mode(NORMAL_MODE)
            self.set_oversampling(BMP3XX_PRESS_OSR_SETTINGS[1], BMP3XX_TEMP_OSR_SETTINGS[0])
            self.filter_coefficient(BMP3XX_IIR_CONFIG_COEF_0)
            self.set_output_data_rates(BMP3XX_ODR_100_HZ)
        elif mode == NORMAL_PRECISION1:
            self.set_power_mode(NORMAL_MODE)
            self.set_oversampling(BMP3XX_PRESS_OSR_SETTINGS[2], BMP3XX_TEMP_OSR_SETTINGS[0])
            self.filter_coefficient(BMP3XX_IIR_CONFIG_COEF_3)
            self.set_output_data_rates(BMP3XX_ODR_50_HZ)
        elif mode == NORMAL_PRECISION2:
            self.set_power_mode(NORMAL_MODE)
            self.set_oversampling(BMP3XX_PRESS_OSR_SETTINGS[3], BMP3XX_TEMP_OSR_SETTINGS[0])
            self.filter_coefficient(BMP3XX_IIR_CONFIG_COEF_1)
            self.set_output_data_rates(BMP3XX_ODR_50_HZ)
        elif mode == HIGH_PRECISION:
            self.set_power_mode(NORMAL_MODE)
            self.set_oversampling(BMP3XX_PRESS_OSR_SETTINGS[3], BMP3XX_TEMP_OSR_SETTINGS[0])
            self.filter_coefficient(BMP3XX_IIR_CONFIG_COEF_1)
            self.set_output_data_rates(BMP3XX_ODR_12P5_HZ)
        elif mode == ULTRA_PRECISION:
            self.set_power_mode(NORMAL_MODE)
            self.set_oversampling(BMP3XX_PRESS_OSR_SETTINGS[4], BMP3XX_TEMP_OSR_SETTINGS[1])
            self.filter_coefficient(BMP3XX_IIR_CONFIG_COEF_3)
            self.set_output_data_rates(BMP3XX_ODR_25_HZ)
        else:
            ret = False
        return ret

    def enable_data_ready_int(self):
        '''!
          @brief Enable interrupt of sensor data ready signal
          @note As the interrupt pin is unique, the three interrupts are set to be used 
          @n    separately, please note the other two interrupt functions when using
        '''
        self._write_reg(BMP3XX_INT_CTRL, 0x42)
        utime.sleep(0.02)

    def enable_fifo_wtm_int(self, wtm_value):
        '''!
          @brief Enable the interrupt of the sensor FIFO reaching the water level signal
          @note As the interrupt pin is unique, the three interrupts are set to be used 
          @n    separately, please note the other two interrupt functions when using
          @param wtm_value: Set the water level value of FIFO (Range: 0-511)
        '''
        self._write_reg(BMP3XX_INT_CTRL, 0x0A)
        self._write_reg(BMP3XX_FIFO_WTM_0, wtm_value & 0xFF)
        self._write_reg(BMP3XX_FIFO_WTM_1, (wtm_value >> 8) & 0x01)
        utime.sleep(0.02)

    def enable_fifo_full_int(self):
        '''!
          @brief Enable the interrupt of the signal that the sensor FIFO is full
          @note As the interrupt pin is unique, the three interrupts are set to be used 
          @n    separately, please note the other two interrupt functions when using
        '''
        self._write_reg(BMP3XX_INT_CTRL, 0x12)
        utime.sleep(0.02)

    def _get_coefficients(self):
        '''!
          @brief Get the calibration data in the NVM register of the sensor
        '''
        calib = self._read_reg(BMP3XX_CALIB_DATA, 21)
        self._data_calib = (
            ((calib[1] << 8) | calib[0]) / 2 ** -8.0,  # T1
            ((calib[3] << 8) | calib[2]) / 2 ** 30.0,  # T2
            self._uint8_to_int(calib[4]) / 2 ** 48.0,  # T3
            (self._uint16_to_int((calib[6] << 8) | calib[5]) - 2 ** 14.0) / 2 ** 20.0,  # P1
            (self._uint16_to_int((calib[8] << 8) | calib[7]) - 2 ** 14.0) / 2 ** 29.0,  # P2
            self._uint8_to_int(calib[9]) / 2 ** 32.0,  # P3
            self._uint8_to_int(calib[10]) / 2 ** 37.0,  # P4
            ((calib[12] << 8) | calib[11]) / 2 ** -3.0,  # P5
            ((calib[14] << 8) | calib[13]) / 2 ** 6.0,  # P6
            self._uint8_to_int(calib[15]) / 2 ** 8.0,  # P7
            self._uint8_to_int(calib[16]) / 2 ** 15.0,  # P8
            (self._uint16_to_int(calib[18] << 8) | calib[17]) / 2 ** 48.0,  # P9
            self._uint8_to_int(calib[19]) / 2 ** 48.0,  # P10
            self._uint8_to_int(calib[20]) / 2 ** 65.0,  # P11
        )

    def _compensate_data(self, adc_p, adc_t):
        '''!
          @brief Use the obtained calibration data to calibrate and compensate the original value of the measured data
          @param adc_p the variable for storing pressure measured data
          @param adc_t the variable for storing temperature measured data
          @note Temperature unit: °C; Pressure unit: Pa
          @return Return the calibrated pressure data and the calibrated temperature data
        '''
        # datasheet, p28, Trimming Coefficient listing in register map with size and sign attributes
        t1, t2, t3, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11 = self._data_calib

        # Temperature compensation
        pd1 = adc_t - t1
        pd2 = pd1 * t2
        temperature = pd2 + (pd1 * pd1) * t3

        # Pressure compensation
        pd1 = p6 * temperature
        pd2 = p7 * temperature ** 2.0
        pd3 = p8 * temperature ** 3.0
        po1 = p5 + pd1 + pd2 + pd3
        pd1 = p2 * temperature
        pd2 = p3 * temperature ** 2.0
        pd3 = p4 * temperature ** 3.0
        po2 = adc_p * (p1 + pd1 + pd2 + pd3)
        pd1 = adc_p ** 2.0
        pd2 = p9 + p10 * temperature
        pd3 = pd1 * pd2
        pd4 = pd3 + p11 * adc_p ** 3.0
        pressure = po1 + po2 + pd4 #- self.sea_level_pressure + STANDARD_SEA_LEVEL_PRESSURE_PA
        return round(pressure, 2), round(temperature, 2)

    def _get_reg_temp_press_data(self):
        '''!
          @brief Obtain the raw measurement data of uncompensated and calibrated pressure and temperature from the register
          @return Return raw measurement data of pressure and temperature: adc_p, adc_t
        '''
        data = self._read_reg(BMP3XX_P_DATA_PA, 6)
        adc_p = data[2] << 16 | data[1] << 8 | data[0]
        adc_t = data[5] << 16 | data[4] << 8 | data[3]

        return adc_p, adc_t

    def get_fifo_temp_press_data(self):
        '''!
          @brief Get the cached data in the FIFO
          @return Return the calibrated pressure data and the calibrated temperature data 
          @n      Temperature unit: °C; Pressure unit: Pa
        '''
        data = self._read_reg(BMP3XX_FIFO_DATA, BMP3XX_FIFO_DATA_FRAME_LENGTH)
        adc_p, adc_t = 0, 0
        if data[0] == BMP3_FIFO_TEMP_PRESS_FRAME:
            adc_t = data[3] << 16 | data[2] << 8 | data[1]
            adc_p = data[6] << 16 | data[5] << 8 | data[4]
        elif data[0] == BMP3_FIFO_TEMP_FRAME:
            adc_t = data[3] << 16 | data[2] << 8 | data[1]
        elif data[0] == BMP3_FIFO_PRESS_FRAME:
            adc_p = data[3] << 16 | data[2] << 8 | data[1]
        elif data[0] == BMP3_FIFO_TIME_FRAME:
            print("FIFO time: ",(data[3] << 16 | data[2] << 8 | data[1]))
        elif data[0] == BMP3_FIFO_CONFIG_CHANGE:
            print("FIFO config change!!!")
        else:
            print("FIFO ERROR!!!")

        if (adc_p > 0):
            adc_p, adc_t = self._compensate_data(adc_p, adc_t)

        return adc_p, adc_t

    def get_fifo_length(self):
        '''!
          @brief Get FIFO cached data size
          @return The range of return value is: 0-511
        '''
        len = self._read_reg(BMP3XX_FIFO_LENGTH, 2)
        return len[0] | (len[1] << 8)

    def empty_fifo(self):
        '''!
          @brief Clear cached data in the FIFO without changing its settings  
        '''
        self._write_reg(BMP3XX_CMD, BMP3XX_CMD_FIFO_FLUSH)
        utime.sleep(0.02)

    def reset(self):
        '''!
          @brief Reset and restart the sensor, restoring the sensor configuration to the default configuration
        '''
        self._write_reg(BMP3XX_CMD, BMP3XX_CMD_RESET)

    def _write_reg(self, reg, data):
        '''!
          @brief writes data to a register
          @param reg register address
          @param data written data
        '''
        # Low level register writing, not implemented in base class
        raise NotImplementedError()

    def _read_reg(self, reg, length):
        '''!
          @brief read the data from the register
          @param reg register address
          @param length read data length
          @return read data list
        '''
        # Low level register writing, not implemented in base class
        raise NotImplementedError()


class BMP3XX_I2C(BMP3XX):
    '''!
      @brief define BMP3XX_I2C base class
      @details for using I2C protocol to drive the pressure sensor
    '''

    def __init__(self, i2c_addr=0x77, bus=1):
        '''!
          @brief Module I2C communication init
          @param i2c_addr I2C communication address
          @param bus I2C bus
        '''
        self._addr = i2c_addr
        self.i2c = I2C(bus)
        super(BMP3XX_I2C, self).__init__()

    def _write_reg(self, reg, data):
        '''!
          @brief writes data to a register
          @param reg register address
          @param data written data
        '''
        if isinstance(data, int):
            data = [data]
        self.i2c.write_i2c_block_data(self._addr, reg, data)

    def _read_reg(self, reg, length):
        '''!
          @brief read the data from the register
          @param reg register address
          @param length read data length
          @return read data list
        '''
        return self.i2c.read_i2c_block_data(self._addr, reg, length)




