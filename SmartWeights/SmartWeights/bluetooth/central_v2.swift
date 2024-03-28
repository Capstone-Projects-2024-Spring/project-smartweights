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
    private var peripherals = [CBPeripheral]()
    
    
    
   
    //TODO: Get ID OF OTHER PICOS
    //peripheral ID for the picos
    private var MPU6050_1_ID = "C6AE350F-CE7B-E617-CA34-811668D1E7CC"
    private var MPU6050_2_ID = "4E4168A3-43AC-4B91-F952-F6712BF345FC"
    
    
    //TODO: Refactor to store in a dictionary
    //MPU6050_1
    private var xCharacteristic: CBCharacteristic!
    private var yCharacteristic: CBCharacteristic!
    private var zCharacteristic: CBCharacteristic!
    
    //MPU6050_2
    private var xCharacteristic2: CBCharacteristic!
    private var yCharacteristic2: CBCharacteristic!
    private var zCharacteristic2: CBCharacteristic!
    
    
    //predefined characteristics
    private var serviceUUID = CBUUID(string: "4A40")
    private var xCharacteristicUUID = CBUUID(string: "4A41")
    private var yCharacteristicUUID = CBUUID(string: "4A42")
    private var zCharacteristicUUID = CBUUID(string: "4A43")
    
    
    
    
    //TODO: Clean up    
    @Published var MPU6050_1: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var MPU6050_2: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var MPU6050_1Accelerations: [[Int]] = [] //stores all the acceleration
    @Published var MPU6050_2Accelerations: [[Int]] = [] //stores all the acceleration
    @Published var scanningToggle = false
    @Published var isConnected = false
    
    @Published var listOfPeripherals = []
    @Published var peripheralData: [UUID: [Int]] = [:]
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    //scans for devices with the serviceUUID
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        }
        else{
            print("no Bluetooth devices found")
        }
    }
    
    
    //connects to the device with the serviceUUID
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
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        self.isConnected = false
        
        
    }
    //initiates the discovery of services with a specific UUID on the connected peripheral after a successful connection
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([serviceUUID])
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
    
    //characteristics are discovered for a service offered by a peripheral
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            
            for characteristic in characteristics {
                
                if characteristic.uuid == xCharacteristicUUID {
                    if peripheral.identifier.uuidString == MPU6050_1_ID{
                        xCharacteristic = characteristic
                    }
                    else{
                        xCharacteristic2 = characteristic
                    }
                    
                    
                    peripheral.setNotifyValue(true, for: characteristic)
                } else if characteristic.uuid == yCharacteristicUUID {
                    if peripheral.identifier.uuidString == MPU6050_1_ID{
                        yCharacteristic = characteristic
                    }
                    else{
                        yCharacteristic2 = characteristic
                    }
                    
                    
                    peripheral.setNotifyValue(true, for: characteristic)
                } else if characteristic.uuid == zCharacteristicUUID {
                    if peripheral.identifier.uuidString == MPU6050_1_ID{
                        zCharacteristic = characteristic
                    }
                    else{
                        zCharacteristic2 = characteristic
                    }
                    
                    
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Failed to read characteristic value: \(error)")
            return
        }
        
        if let data = characteristic.value{
            let acceleration: Int = data.withUnsafeBytes { bufferPointer in
                guard let ptr = bufferPointer.baseAddress?.assumingMemoryBound(to: Int16.self) else {
                    return 0
                }
                let floatValue = ptr.pointee
                return Int(floatValue)
            }
            
            DispatchQueue.main.async {
                
                
                if peripheral.identifier.uuidString == self.MPU6050_2_ID{
                    if characteristic == self.xCharacteristic2 {
                        self.MPU6050_2[0] = acceleration
                    } else if characteristic == self.yCharacteristic2 {
                        self.MPU6050_2[1] = acceleration
                    } else if characteristic == self.zCharacteristic2 {
                        self.MPU6050_2[2] = acceleration
                        //adding the accerlation into the overall array
                        self.MPU6050_2Accelerations.append(self.MPU6050_2)
                        self.peripheralData[peripheral.identifier]?.append(contentsOf: self.MPU6050_2)
                        print("MPU6050_2")
                        print("\(self.MPU6050_2Accelerations)")
                    }
                    
                }
                
                
                else if peripheral.identifier.uuidString == self.MPU6050_1_ID{
                    if characteristic == self.xCharacteristic {
                        self.MPU6050_1[0] = acceleration
                    } else if characteristic == self.yCharacteristic {
                        self.MPU6050_1[1] = acceleration
                    } else if characteristic == self.zCharacteristic {
                        self.MPU6050_1[2] = acceleration
                        //adding the accerlation into the overall array
                        self.MPU6050_1Accelerations.append(self.MPU6050_1)
                        self.peripheralData[peripheral.identifier]?.append(contentsOf: self.MPU6050_1)
                        print("MPU6050_1")
                        print("\(self.MPU6050_1Accelerations)")
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
            
            
        }
        
        
    }
    
}




#Preview {
    bleView()
}

