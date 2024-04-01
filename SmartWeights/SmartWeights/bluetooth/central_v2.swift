import SwiftUI
import CoreBluetooth



/*
Bluetooth will only work if it being tested on an external device with Bluetooth capabilities
 
 current status - picos will automatically connect the moment the BLEcentral class is initialize.
                    The picos will be kept turned on. (Have user turn all sensors on prior the starting workout)
                    The sensors will continuously send data. But only when collectedDataToggle == True will the app collect data.
                    This makes starting the workout easier, since sensors are always connected.


TODO: Connect three more picos - in progress
TODO: Refactor the code to handle three more picos - in progress
TODO: Read gyroscope data - done
 */



//let phone act as GATT central device
class BLEcentral: NSObject, CBCentralManagerDelegate,CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager! //handle ble scanning. state, connecting, disconnecting
    private var peripherals = Array<CBPeripheral?>(repeating: nil, count: 5) //store all connected peripherals, initialize array with size 5
    
    
    //TODO: Get ID OF OTHER PICOS
    //peripheral ID for the picos
    private var MPU6050_1_ID = "C6AE350F-CE7B-E617-CA34-811668D1E7CC"
    private var MPU6050_2_ID = "4E4168A3-43AC-4B91-F952-F6712BF345FC"
    
    //private var MPU_1_Name = "Optional(\"MPU6050-1\")"
    private var MPU_1_Name = "MPU6050-1"
    
    private var MPU_2_Name = "Optional(\"MPU6050-2\")"
    
    
    
    //MPU6050_1
    private var axCharacteristic: CBCharacteristic!
    private var ayCharacteristic: CBCharacteristic!
    private var azCharacteristic: CBCharacteristic!
    private var gxCharacteristic: CBCharacteristic!
    private var gyCharacteristic: CBCharacteristic!
    private var gzCharacteristic: CBCharacteristic!
    
    //MPU6050_2
    private var axCharacteristic2: CBCharacteristic!
    private var ayCharacteristic2: CBCharacteristic!
    private var azCharacteristic2: CBCharacteristic!
    private var gxCharacteristic2: CBCharacteristic!
    private var gyCharacteristic2: CBCharacteristic!
    private var gzCharacteristic2: CBCharacteristic!
    
    
    //predefined characteristics
    private var AccelServiceUUID = CBUUID(string: "4A40")
    private var GyroServiceUUID = CBUUID(string: "4A50")
    //accel characteristics
    private var axCharacteristicUUID = CBUUID(string: "4A41")
    private var ayCharacteristicUUID = CBUUID(string: "4A42")
    private var azCharacteristicUUID = CBUUID(string: "4A43")
    //gyro characteristics
    private var gxCharacteristicUUID = CBUUID(string: "4A51")
    private var gyCharacteristicUUID = CBUUID(string: "4A52")
    private var gzCharacteristicUUID = CBUUID(string: "4A53")
    
    
    
    
    //TODO: Clean up
    @Published var MPU6050_1_Accel: [Int] = [0, 0, 0] // Array to store current acceleration of MPU6050-1
    @Published var MPU6050_2_Accel: [Int] = [0, 0, 0] // Array to store current acceleration of MPU6050-2
    @Published var MPU6050_1_Gyro: [Int] = [0, 0, 0] // Array to store current gyro rotation of MPU6050-1
    @Published var MPU6050_2_Gyro: [Int] = [0, 0, 0] // Array to store current gyro rotation of MPU6050-2
    @Published var MPU6050_1Accelerations: [[Int]] = [] //stores all the acceleration of MPU6050-1
    @Published var MPU6050_2Accelerations: [[Int]] = [] //stores all the acceleration of MPU6050-2
    @Published var MPU6050_1Gyros: [[Int]] = [] //stores all the gyro data of MPU6050-1
    @Published var MPU6050_2Gyros: [[Int]] = [] //stores all the gyro data of MPU6050-2
    @Published var collectDataToggle = false//
    @Published var isConnected = false
    
    @Published var listOfPeripherals = []
    @Published var peripheralData = [:]
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //scans for devices with the AccelServiceUUID
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        // check if SmartWeights' bluetooth is on
        if central.state == .poweredOn{
            centralManager.scanForPeripherals(withServices: [AccelServiceUUID,GyroServiceUUID], options: nil) //scanning for peripherals with specify services (predefined in MicroPython)
        }
        else{
            print("bluetooth error")
        }
    }
    
        
    
    //connects to peripherals with the specified service UUID
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        //add MPU6050-1 in list of connected
        //if peripheral.identifier.uuidString == "C6AE350F-CE7B-E617-CA34-811668D1E7CC"
        if peripheral.name == MPU_1_Name{
            peripherals.insert(peripheral, at: 0)
        }
        //add MPU6050-2 in list of connected
        //else if peripheral.identifier.uuidString == "4E4168A3-43AC-4B91-F952-F6712BF345FC"
        else if peripheral.name == MPU_2_Name{
            peripherals.insert(peripheral, at: 1)
        }
        //connecting the peripheral to the app
        centralManager.connect(peripheral, options: nil)
        peripheralData[peripheral.name] = []
        print(peripheral.name as Any)
        
    }
    
    //starts scanning once a peripheral is disconnected
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral == peripherals[0]{
            peripherals[0] = nil
        }
        else if peripheral == peripherals[1]{
            peripherals[1] = nil
            
        }
        print("\(peripheral)")
        print("\(peripherals)")
        centralManager.scanForPeripherals(withServices: [AccelServiceUUID,GyroServiceUUID], options: nil)
        self.isConnected = false
        
        
    }
    //initiates the discovery of services with a specific UUID on the connected peripheral after a successful connection
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([AccelServiceUUID,GyroServiceUUID])
        self.isConnected = true
        listOfPeripherals.append(peripheral)
        print(peripheral)
    }
    
    //if a bluetooth device could not connect correctly
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral), error: \(String(describing: error))")
    }
    
    //discover the services from the peripheral
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    //TODO: refactor this section for readability and scalability
    //characteristics are discovered for a service offered by a peripheral
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        
        if service.uuid == AccelServiceUUID{
            if let characteristics = service.characteristics {
                
                for characteristic in characteristics {
                    
                    if characteristic.uuid == axCharacteristicUUID {
                        //if peripheral.identifier.uuidString == MPU6050_1_ID
                        if peripheral.name == MPU_1_Name{
                            axCharacteristic = characteristic
                        }
                        else if peripheral.identifier.uuidString == MPU6050_2_ID{
                            axCharacteristic2 = characteristic
                        }
                        
                        peripheral.setNotifyValue(true, for: characteristic)
                        
                    } else if characteristic.uuid == ayCharacteristicUUID {
                        //if peripheral.identifier.uuidString == MPU6050_1_ID
                        if peripheral.name == MPU_1_Name{
                            ayCharacteristic = characteristic
                        }
                        else if peripheral.identifier.uuidString == MPU6050_2_ID{
                            ayCharacteristic2 = characteristic
                        }
                        
                        peripheral.setNotifyValue(true, for: characteristic)
                        
                    } else if characteristic.uuid == azCharacteristicUUID {
                        //if peripheral.identifier.uuidString == MPU6050_1_ID
                        if peripheral.name == MPU_1_Name{
                            azCharacteristic = characteristic
                        }
                        else if peripheral.identifier.uuidString == MPU6050_2_ID{
                            azCharacteristic2 = characteristic
                        }
                        
                        peripheral.setNotifyValue(true, for: characteristic)
                    }
                }
            }
        }
        
        if service.uuid == GyroServiceUUID{
            if let characteristic = service.characteristics{
                for characteristic in characteristic{
                    if characteristic.uuid == gxCharacteristicUUID{
                        if peripheral.identifier.uuidString == MPU6050_1_ID{
                            gxCharacteristic = characteristic
                        }
                        else if peripheral.identifier.uuidString == MPU6050_2_ID{
                            gxCharacteristic2 = characteristic
                        }
                        peripheral.setNotifyValue(true, for: characteristic)
                    }
                    
                    else if characteristic.uuid == gyCharacteristicUUID{
                        if peripheral.identifier.uuidString == MPU6050_1_ID{
                            gyCharacteristic = characteristic
                        }
                        else if peripheral.identifier.uuidString == MPU6050_2_ID{
                            gyCharacteristic2 = characteristic
                        }
                        peripheral.setNotifyValue(true, for: characteristic)
                    }
                    
                    else if characteristic.uuid == gzCharacteristicUUID{
                        if peripheral.identifier.uuidString == MPU6050_1_ID{
                            gzCharacteristic = characteristic
                        }
                        else if peripheral.identifier.uuidString == MPU6050_2_ID{
                            gzCharacteristic2 = characteristic
                        }
                        peripheral.setNotifyValue(true, for: characteristic)
                    }
                    
                }
            }
        }
        
    }
    //gets the updated data from the characteristic
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Failed to read characteristic value: \(error)")
            return
        }
        //obtaining the data from the characeteristic
        if let incomingData = characteristic.value{
            let data: Int = incomingData.withUnsafeBytes { bufferPointer in
                guard let ptr = bufferPointer.baseAddress?.assumingMemoryBound(to: Int16.self) else {
                    return 0
                }
                let floatValue = ptr.pointee
                return Int(floatValue)
            }
            //updates the correct array based on the characteristic
            DispatchQueue.main.async {
                switch peripheral.name{
                    case self.MPU_1_Name:
                        switch characteristic{
                            case self.axCharacteristic:
                                self.MPU6050_1_Accel[0] = data
                            case self.ayCharacteristic:
                                self.MPU6050_1_Accel[1] = data
                            case self.azCharacteristic:
                                self.MPU6050_1_Accel[2] = data
                            if self.collectDataToggle{
                                self.MPU6050_1Accelerations.append(self.MPU6050_1_Accel)
                            }
//                                self.peripheralData[peripheral.identifier]?.append(contentsOf: self.MPU6050_1_Accel)
                            case self.gxCharacteristic:
                                self.MPU6050_1_Gyro[0] = data
                            case self.gyCharacteristic:
                                self.MPU6050_1_Gyro[1] = data
                            case self.gzCharacteristic:
                                self.MPU6050_1_Gyro[2] = data
                            if self.collectDataToggle{
                                self.MPU6050_1Gyros.append(self.MPU6050_1_Gyro)
                            }
                                print("MPU6050_1 gyro")
                                print("\(self.MPU6050_1Gyros)")
                            default:
                                break
                        }
                    case self.MPU6050_2_ID:
                        switch characteristic{
                            case self.axCharacteristic2:
                                self.MPU6050_2_Accel[0] = data
                            case self.ayCharacteristic2:
                                self.MPU6050_2_Accel[1] = data
                            case self.azCharacteristic2:
                                self.MPU6050_2_Accel[2] = data
                            if self.collectDataToggle{
                                self.MPU6050_2Accelerations.append(self.MPU6050_2_Accel)
                            }
//                                self.peripheralData[peripheral.identifier]?.append(contentsOf: self.MPU6050_2_Accel)
                            case self.gxCharacteristic2:
                                self.MPU6050_2_Gyro[0] = data
                            case self.gyCharacteristic2:
                                self.MPU6050_2_Gyro[1] = data
                            case self.gzCharacteristic2:
                                self.MPU6050_2_Gyro[2] = data
                            if self.collectDataToggle{
                                self.MPU6050_2Gyros.append(self.MPU6050_2_Gyro)
                            }
                                print("MPU6050_2 gyro")
                                print("\(self.MPU6050_2Gyros)")
                            default:
                                break
                            
                        }
                        
                    default:
                        break
                }
                
            }
            
        }
    }
    
}

struct bleView : View {
    //initialize bluetooth
    @ObservedObject var ble = BLEcentral()
    
    var body: some View {
        //allow the app to start collecting data
        Button(action: {
            ble.collectDataToggle = true
        }, label: {
            Text("start workout")
        })
        .padding(.top,20)
        //stops the app from collecting data
        Button(action: {
            ble.collectDataToggle = false
        }, label: {
            Text("finish workout")
        })
        .padding(.top, 100)
        //show peripheral connection
        Text("\(ble.listOfPeripherals)")
        //show all data being sent by peripherals
        Text("\(ble.peripheralData)")
        
        HStack{
            //list the accel and gyro data for MPU6050-1
            HStack{
                List{
                    ForEach(ble.MPU6050_1Accelerations, id: \.self) { acceleration in
                        VStack(alignment: .leading) {
                            Text("MPU6050_1 Acceleration:")
                                .font(.headline)
                            ForEach(0..<acceleration.count, id: \.self) { index in
                                Text("\(index == 0 ? "X: " : index == 1 ? "Y: " : "Z: ")\(acceleration[index])")
                            }
                        }
                    }
                }
                List{
                    ForEach(ble.MPU6050_1Gyros, id: \.self) { gyro in
                        VStack(alignment: .leading) {
                            Text("MPU6050_1 Gyro:")
                                .font(.headline)
                            ForEach(0..<gyro.count, id: \.self) { index in
                                Text("\(index == 0 ? "X: " : index == 1 ? "Y: " : "Z: ")\(gyro[index])")
                            }
                        }
                    }
                }
                
            }
            //list the accel and gyro data for MPU6050-2
            HStack{
                List{
                    ForEach(ble.MPU6050_2Accelerations, id: \.self) { acceleration in
                        VStack(alignment: .leading) {
                            Text("MPU6050_2 Acceleration:")
                                .font(.headline)
                            ForEach(0..<acceleration.count, id: \.self) { index in
                                Text("\(index == 0 ? "X: " : index == 1 ? "Y: " : "Z: ")\(acceleration[index])")
                            }
                        }
                    }
                    
                }
                List{
                    ForEach(ble.MPU6050_2Gyros, id: \.self) { gyro in
                        VStack(alignment: .leading) {
                            Text("MPU6050_2 Gyro:")
                                .font(.headline)
                            ForEach(0..<gyro.count, id: \.self) { index in
                                Text("\(index == 0 ? "X: " : index == 1 ? "Y: " : "Z: ")\(gyro[index])")
                            }
                        }
                    }
                }
            }
        }
    }
}




#Preview {
    bleView()
}

