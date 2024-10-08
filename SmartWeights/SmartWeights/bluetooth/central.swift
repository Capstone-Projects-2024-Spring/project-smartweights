import SwiftUI
import CoreBluetooth

//WILL ONLY WORK IF BUILT ON AN EXTERNAL DEVICE WITH BLUETOOTH

//let phone act as GATT central device
class BLEManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager! //handle ble scanning. state, connecting, disconnecting
    private var peripheral: CBPeripheral!
    private var xCharacteristic: CBCharacteristic!
    private var yCharacteristic: CBCharacteristic!
    private var zCharacteristic: CBCharacteristic!
    
    //These CBUUID are set on the pico
    private var serviceUUID = CBUUID(string: "4A40")
    private var xCharacteristicUUID = CBUUID(string: "4A41")
    private var yCharacteristicUUID = CBUUID(string: "4A42")
    private var zCharacteristicUUID = CBUUID(string: "4A43")
    
    
    @Published var accelerations: [Int] = [0, 0, 0] // Array to store current acceleration
    @Published var AllAccelerations: [[Int]] = []
    @Published var scanningToggle = false
    @Published var isConnected = false
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        }
    }
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral = peripheral
        self.peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        // Restart scanning for peripherals when disconnected
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        self.isConnected = false
        
        
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([serviceUUID])
        self.isConnected = true
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                peripheral.discoverCharacteristics(nil, for: service)
            }
            
        }
    }
    
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
        if let data = characteristic.value {
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
                    self.AllAccelerations.append(self.accelerations)
                }
                
            }
            
            
        }
    }
}

struct bluetoothView: View {
    @StateObject var bleManager = BLEManager()
    
    
    var body: some View {
        VStack {
            if bleManager.isConnected{
                Text("Sensor connected")
            }
            else{
                Text("Sensor disconnected")
            }
            Text("Acceleration - X: \(bleManager.accelerations[0]) Y: \(bleManager.accelerations[1]) Z: \(bleManager.accelerations[2])") // Display the last temperature in the array
                .padding()
            
            List {
                ForEach(bleManager.AllAccelerations, id: \.self) { acceleration in
                    VStack(alignment: .leading) {
                        Text("Acceleration:")
                            .font(.headline)
                        ForEach(0..<acceleration.count, id: \.self) { index in
                            Text("\(index == 0 ? "X: " : index == 1 ? "Y: " : "Z: ")\(acceleration[index])")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            
            
            
            
        }
    }
}
#Preview {
    bluetoothView()
}
