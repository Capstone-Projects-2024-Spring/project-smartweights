import SwiftUI
import CoreBluetooth



/*
 Bluetooth will only work if it being tested on an external device with Bluetooth capabilities
 
 
 TODO: TConnect three more picos
 TODO: Refactor the code to handle three more picos
 TODO: Read gyroscope data
 TODO: Current data being sent is Int, might change to Float or byteArray
 
 
 */




//let phone act as GATT central device
class BLEcentral: NSObject, CBCentralManagerDelegate,CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager! //handle ble scanning. state, connecting, disconnecting
    private var peripherals = [CBPeripheral]() //store all connected peripherals
    
    
    
    
    //TODO: Get ID OF OTHER PICOS
    //peripheral ID for the picos
    private var MPU6050_1_ID = "C6AE350F-CE7B-E617-CA34-811668D1E7CC"
    private var MPU6050_2_ID = "4E4168A3-43AC-4B91-F952-F6712BF345FC"
    
    
    //TODO: Refactor to store in a dictionary
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
    
    private var axCharacteristicUUID = CBUUID(string: "4A41") //need to change name
    private var ayCharacteristicUUID = CBUUID(string: "4A42")
    private var azCharacteristicUUID = CBUUID(string: "4A43")
    private var gxCharacteristicUUID = CBUUID(string: "4A51")
    private var gyCharacteristicUUID = CBUUID(string: "4A52")
    private var gzCharacteristicUUID = CBUUID(string: "4A53")
    
    
    
    
    //TODO: Clean up
    @Published var MPU6050_1_Accel: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var MPU6050_2_Accel: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var MPU6050_1_Gyro: [Int] = [0, 0, 0] // Array to store current gyro
    @Published var MPU6050_2_Gyro: [Int] = [0, 0, 0] // Array to store current gyro
    @Published var MPU6050_1Accelerations: [[Int]] = [] //stores all the acceleration
    @Published var MPU6050_2Accelerations: [[Int]] = [] //stores all the acceleration
     @Published var MPU6050_1Gyros: [[Int]] = [] //stores all the gyro data
    @Published var MPU6050_2Gyros: [[Int]] = [] //stores all the gyro data
    @Published var scanningToggle = false
    @Published var isConnected = false
    
    @Published var listOfPeripherals = []
    @Published var peripheralData: [UUID: [Int]] = [:]
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //scans for devices with the AccelServiceUUID
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            centralManager.scanForPeripherals(withServices: [AccelServiceUUID,GyroServiceUUID], options: nil)
        }
        else{
            print("no Bluetooth devices found")
        }
    }
    
    
    //connects to the device with the AccelServiceUUID
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if peripheral.identifier.uuidString == "4E4168A3-43AC-4B91-F952-F6712BF345FC"{
            peripherals.insert(peripheral, at: 0)
        }
        else{
            peripherals.append(peripheral)
        }
        centralManager.connect(peripheral, options: nil)
        peripheralData[peripheral.identifier] = []
        
    }
    
    //starts scanning once the peripheral is disconnected
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral == peripherals[0]{
            peripherals.remove(at: 0)
            
        }
        else{
            peripherals.remove(at: 1)
            
        }
        print("\(peripheral)")
        print("\(peripherals)")
        centralManager.scanForPeripherals(withServices: [AccelServiceUUID,GyroServiceUUID], options: nil)
        self.isConnected = false
        
        
    }
    //initiates the discovery of services with a specific UUID on the connected peripheral after a successful connection
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([AccelServiceUUID,GyroServiceUUID])
        peripheral.delegate = self
        self.isConnected = true
        listOfPeripherals.append(peripheral)
        print(peripheral)
        
    }
    
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Failed to connect to peripheral: \(peripheral), error: \(String(describing: error))")
    }
    
    //discover the services from the device
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
                        if peripheral.identifier.uuidString == MPU6050_1_ID{
                            axCharacteristic = characteristic
                        }
                        else{
                            axCharacteristic2 = characteristic
                        }
                        
                        peripheral.setNotifyValue(true, for: characteristic)
                        
                    } else if characteristic.uuid == ayCharacteristicUUID {
                        if peripheral.identifier.uuidString == MPU6050_1_ID{
                            ayCharacteristic = characteristic
                        }
                        else{
                            ayCharacteristic2 = characteristic
                        }
                        
                        peripheral.setNotifyValue(true, for: characteristic)
                        
                    } else if characteristic.uuid == azCharacteristicUUID {
                        if peripheral.identifier.uuidString == MPU6050_1_ID{
                            azCharacteristic = characteristic
                        }
                        else{
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
                            else{
                                gxCharacteristic2 = characteristic
                            }
                            peripheral.setNotifyValue(true, for: characteristic)
                        }
                        
                        else if characteristic.uuid == gyCharacteristicUUID{
                            if peripheral.identifier.uuidString == MPU6050_1_ID{
                                gyCharacteristic = characteristic
                            }
                            else{
                                gyCharacteristic2 = characteristic
                            }
                            peripheral.setNotifyValue(true, for: characteristic)
                        }
                        
                        else if characteristic.uuid == gzCharacteristicUUID{
                            if peripheral.identifier.uuidString == MPU6050_1_ID{
                                gzCharacteristic = characteristic
                            }
                            else{
                                gzCharacteristic2 = characteristic
                            }
                            peripheral.setNotifyValue(true, for: characteristic)
                        }
                        
                    }
                }
            }

    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Failed to read characteristic value: \(error)")
            return
        }
        
        if let incomingData = characteristic.value{
            let data: Int = incomingData.withUnsafeBytes { bufferPointer in
                guard let ptr = bufferPointer.baseAddress?.assumingMemoryBound(to: Int16.self) else {
                    return 0
                }
                let floatValue = ptr.pointee
                return Int(floatValue)
            }
            
            DispatchQueue.main.async {
                
                if peripheral.identifier.uuidString == self.MPU6050_2_ID{
                    if characteristic == self.axCharacteristic2 {
                        self.MPU6050_2_Accel[0] = data
                    }
                    else if characteristic == self.ayCharacteristic2 {
                        self.MPU6050_2_Accel[1] = data
                    }
                    else if characteristic == self.azCharacteristic2 {
                        self.MPU6050_2_Accel[2] = data
                        //adding the acceleration into the overall array
                        self.MPU6050_2Accelerations.append(self.MPU6050_2_Accel)
                        self.peripheralData[peripheral.identifier]?.append(contentsOf: self.MPU6050_2_Accel)
                        print("MPU6050_2 accel")
                        print("\(self.MPU6050_2Accelerations)")
                    }
                    else if characteristic == self.gxCharacteristic2 {
                        self.MPU6050_2_Gyro[0] = data
                    }
                    else if characteristic == self.gyCharacteristic2 {
                        self.MPU6050_2_Gyro[1] = data
                    }
                    else if characteristic == self.gzCharacteristic2 {
                        self.MPU6050_2_Gyro[2] = data
                        //adding the gyroscope into the overall array
                        self.MPU6050_2Gyros.append(self.MPU6050_2_Gyro)
                        print("MPU6050_2 gyro")
                        print("\(self.MPU6050_2Gyros)")
                    }
                    
                }
                
                
                else if peripheral.identifier.uuidString == self.MPU6050_1_ID{
                    if characteristic == self.axCharacteristic {
                        self.MPU6050_1_Accel[0] = data
                    }
                    else if characteristic == self.ayCharacteristic {
                        self.MPU6050_1_Accel[1] = data
                    }
                    else if characteristic == self.azCharacteristic {
                        self.MPU6050_1_Accel[2] = data
                        //adding the accerlation into the overall array
                        self.MPU6050_1Accelerations.append(self.MPU6050_1_Accel)
                        self.peripheralData[peripheral.identifier]?.append(contentsOf: self.MPU6050_1_Accel)
                        print("MPU6050_1 accel")
                        print("\(self.MPU6050_1Accelerations)")
                    }
                    else if characteristic == self.gxCharacteristic {
                        self.MPU6050_1_Gyro[0] = data
                    }
                    else if characteristic == self.gyCharacteristic {
                        self.MPU6050_1_Gyro[1] = data
                    }
                    else if characteristic == self.gzCharacteristic {
                        self.MPU6050_1_Gyro[2] = data
                        //adding the gyroscope into the overall array
                        self.MPU6050_1Gyros.append(self.MPU6050_1_Gyro)
                        print("MPU6050_1 gyro")
                        print("\(self.MPU6050_1Gyros)")
                    }
                    
                }
                
            }
            
        }
    }
    
}

struct bleView : View {
    
    @ObservedObject var ble = BLEcentral()
    
    var body: some View {
        Text("\(ble.listOfPeripherals)")
        Text("\(ble.peripheralData)")
        
        HStack{
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

