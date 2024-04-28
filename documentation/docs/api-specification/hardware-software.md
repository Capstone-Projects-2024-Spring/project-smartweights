# Hardware Software

## Class: MPU6050
Class for reading gyro rates and acceleration data from an MPU-6050 module via I2C.

<details open>



- `read_accel_data() → tuple[float, float, float]`: Read the accelerometer data, in a (x, y, z) tuple.
- `read_accel_range() → int`: Reads the accelerometer range setting.
- `read_gyro_data() → tuple[float, float, float]`: Read the gyroscope data, in a (x, y, z) tuple.
- `read_gyro_range() → int`: Reads the gyroscope range setting.
- `read_temperature() → float`: Reads the temperature, in Celsius, of the onboard temperature sensor.
- `sleep() → None`: Places MPU-6050 in sleep mode (low power consumption).
- `wake() → None`: Wake up the MPU-6050.
- `who_am_i() → int`: Returns the address of the MPU-6050.
- `write_accel_range(range: int) → None`: Sets the accelerometer range setting.
- `write_gyro_range(range: int) → None`: Sets the gyroscope range setting.
- `write_lpf_range(range: int) → None`: Sets low pass filter range.

</details>


## Class: main
A class that is responsible for advertising data via Bluetooth


<details open>



- `advertising_payload(limited_disc=False, br_edr=False, name=None, services=None, appearance=0)`: Generate a payload for advertising.
- `decode_field(payload, adv_type)`: Decode a field from an advertising payload.
- `decode_name(payload)`: Decode the local name from an advertising payload.
- `decode_services(payload)`: Decode a list of UUIDs from an advertising payload.
- `demo()`: Run a demonstration.
  
</details>

## Class: MPU Data

<details open>

Class to get accelerometer and gyroscope data.

- `__init__(id: str)`: The ID of the MPU6050 sensor.
- `get_accel_data() → tuple`: Get the accelerometer data.
- `get_gyro_data() → tuple`: Get the gyroscope data.

</details>

## Class: BLEcentral

BLEcentral is a class that manages a central role in a Bluetooth Low Energy (BLE) connection. It conforms to `NSObject`, `CBCentralManagerDelegate`, `CBPeripheralDelegate`, and `ObservableObject`.


<details open>



### Overview

This class is responsible for scanning for, connecting to, and disconnecting from peripherals.

**Note:** This class specifically looks for peripherals named “MPU6050-1” and “MPU6050-2”.

### Initializers

### `init()`
Initializes the central manager and starts scanning for peripherals with the specified service UUIDs.

### Instance Properties

- `MPU6050_1Accelerations: [[Int]]`
- `MPU6050_1Gyros: [[Int]]`
- `MPU6050_1_Accel: [Int]`
- `MPU6050_1_All_Accelerations: [[Int]]`
- `MPU6050_1_All_Gyros: [[Int]]`
- `MPU6050_1_Gyro: [Int]`
- `MPU6050_2Accelerations: [[Int]]`
- `MPU6050_2Gyros: [[Int]]`
- `MPU6050_2_Accel: [Int]`
- `MPU6050_2_All_Accelerations: [[Int]]`
- `MPU6050_2_All_Gyros: [[Int]]`
- `MPU6050_2_Gyro: [Int]`
- `MPU_1_Connected: Bool`: A boolean that indicates whether MPU6050-1 is connected.
- `MPU_2_Connected: Bool`: A boolean that indicates whether MPU6050-2 is connected.
- `collectDataToggle: Bool`: A boolean that toggles whether the app should collect data from the peripherals.
- `isConnected: Bool`
- `listOfPeripherals: [Any]`
- `peripheralData: [AnyHashable : Any]`

### Instance Methods

- `func centralManager(CBCentralManager, didConnect: CBPeripheral)`: Discovers services on the peripheral.
- `func centralManager(CBCentralManager, didDisconnectPeripheral: CBPeripheral, error: Error?)`: Scans for peripherals with the specified service UUIDs.
- `func centralManager(CBCentralManager, didDiscover: CBPeripheral, advertisementData: [String : Any], rssi: NSNumber)`: Connects to the peripheral with the specified service UUID.
- `func centralManager(CBCentralManager, didFailToConnect: CBPeripheral, error: Error?)`: Discovers the characteristics of the service on the peripheral.
- `func centralManagerDidUpdateState(CBCentralManager)`: Scans for devices with the AccelServiceUUID.
- `func peripheral(CBPeripheral, didDiscoverCharacteristicsFor: CBService, error: Error?)`: Discovers the characteristics of the service on the peripheral.
- `func peripheral(CBPeripheral, didDiscoverServices: Error?)`: Discovers the characteristics of the service on the peripheral.
- `func peripheral(CBPeripheral, didUpdateValueFor: CBCharacteristic, error: Error?)`: Gets the updated data from the characteristic.


</details>




