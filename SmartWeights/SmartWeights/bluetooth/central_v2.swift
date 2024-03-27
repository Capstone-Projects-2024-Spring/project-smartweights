import SwiftUI
import CoreBluetooth

//WILL ONLY WORK IF BUILT ON AN EXTERNAL DEVICE WITH BLUETOOTH

//let phone act as GATT central device
class BLEcentral: NSObject, CBCentralManagerDelegate,CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager! //handle ble scanning. state, connecting, disconnecting
    //private var peripheral: CBPeripheral!
    
    private var peripherals = [CBPeripheral]()
    
    private var xCharacteristic: CBCharacteristic!
    private var yCharacteristic: CBCharacteristic!
    private var zCharacteristic: CBCharacteristic!
    
    //These CBUUID are set on the pico
    private var serviceUUID = CBUUID(string: "4A40")
    private var xCharacteristicUUID = CBUUID(string: "4A41")
    private var yCharacteristicUUID = CBUUID(string: "4A42")
    private var zCharacteristicUUID = CBUUID(string: "4A43")
    
    
    @Published var accelerations: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var MPU6050_1: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var MPU6050_2: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var AllAccelerations: [[Int]] = [] //stores all the acceleration
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
        peripherals.append(peripheral)
        centralManager.connect(peripheral, options: nil)
        peripheralData[peripheral.identifier] = []
        
    }
    
    //starts scanning once the peripheral is disconnected
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
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
                    xCharacteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                } else if characteristic.uuid == yCharacteristicUUID {
                    yCharacteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                } else if characteristic.uuid == zCharacteristicUUID {
                    zCharacteristic = characteristic
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
                if characteristic == self.xCharacteristic {
                    self.accelerations[0] = acceleration
                } else if characteristic == self.yCharacteristic {
                    self.accelerations[1] = acceleration
                } else if characteristic == self.zCharacteristic {
                    self.accelerations[2] = acceleration
                    //adding the accerlation into the overall array
                    self.AllAccelerations.append(self.accelerations)
                    print("\(self.AllAccelerations)")
                    self.peripheralData[peripheral.identifier]?.append(contentsOf: self.accelerations)
                }
                
            }
            
        }
    }
    
}

struct bleView : View {
    
    @ObservedObject var ble = BLEcentral()
    @State var counter = 0
    
    var body: some View {
        Text("\(ble.listOfPeripherals)")
        Text("\(ble.peripheralData)")
        
        List{
            ForEach(ble.AllAccelerations, id: \.self) { acceleration in
                HStack() {
                    Text("Acceleration:")
                    ForEach(0..<acceleration.count, id: \.self) { index in
                        Text("\(index == 0 ? "X: " : index == 1 ? "Y: " : "Z: ")\(acceleration[index])")
                    }
                }
                
            }
        }
    }
}

#Preview {
    bleView()
}

