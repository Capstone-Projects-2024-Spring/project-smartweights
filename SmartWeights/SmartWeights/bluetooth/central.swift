import SwiftUI
import CoreBluetooth

//WILL ONLY WORK IF BUILT ON AN EXTERNAL DEVICE WITH BLUETOOTH

class BLEManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var xCharacteristic: CBCharacteristic!
    private var yCharacteristic: CBCharacteristic!
    private var zCharacteristic: CBCharacteristic!
    
    //These CBUUID are set on the pico
    private var serviceUUID = CBUUID(string: "4A40")
    private var xCharacteristicUUID = CBUUID(string: "4A41")
    private var yCharacteristicUUID = CBUUID(string: "4A42")
    private var zCharacteristicUUID = CBUUID(string: "4A43")

    @Published var accelerations: [Int] = [0, 0, 0] // Array to store acceleration

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        self.peripheral = peripheral
        self.peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([serviceUUID])
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
                let intValue = ptr.pointee
                return Int(intValue)
            }
            DispatchQueue.main.async {
                if characteristic == self.xCharacteristic {
                    self.accelerations[0] = acceleration
                } else if characteristic == self.yCharacteristic {
                    self.accelerations[1] = acceleration
                } else if characteristic == self.zCharacteristic {
                    self.accelerations[2] = acceleration
                }
            }
        }
    }
}

struct bluetoothView: View {
    @StateObject var bleManager = BLEManager()

    var body: some View {
        VStack {
            Text("Acceleration - X: \(bleManager.accelerations[0]) Y: \(bleManager.accelerations[1]) Z: \(bleManager.accelerations[2])") // Display the last temperature in the array
                .padding()

            List {
                ForEach(0..<bleManager.accelerations.count, id: \.self) { index in
                    Text("\(index == 0 ? "X" : index == 1 ? "Y" : "Z"): \(bleManager.accelerations[index])")
                }
            }
            .padding()
        }
    }
}
