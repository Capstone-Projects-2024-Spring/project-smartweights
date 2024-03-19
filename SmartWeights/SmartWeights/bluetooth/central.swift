import SwiftUI
import CoreBluetooth

//WILL ONLY WORK IF BUILT ON AN EXTERNAL DEVICE WITH BLUETOOTH

class BLEManager: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var characteristic: CBCharacteristic!
    
    //These CBUUID are set on the pico for the temperature sample code
    //private var serviceUUID = CBUUID(string: "181A")
    //private var characteristicUUID = CBUUID(string: "2A6E")

    //for the physical  activity service
    private var serviceUUID = CBUUID(string: "183E")
    private var characteristicUUID = CBUUID(string: "2713")
        


    //need to change variables
    //need to change the upacking of data in update
    @Published var temperatures: [Float] = [] // Array to store temperatures

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
                peripheral.discoverCharacteristics([characteristicUUID], for: service)
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == characteristicUUID {
                    self.characteristic = characteristic
                    peripheral.setNotifyValue(true, for: characteristic)
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let data = characteristic.value {
            let temp: Float = data.withUnsafeBytes { bufferPointer in
                guard let ptr = bufferPointer.baseAddress?.assumingMemoryBound(to: Int16.self) else {
                    return 0.0
                }
                let intValue = ptr.pointee
                return Float(intValue) / 100.0
            }
            DispatchQueue.main.async {
                self.temperatures.append(temp) // Append the temperature to the array
            }
        }
    }
}

struct bluetoothView: View {
    @StateObject var bleManager = BLEManager()

    var body: some View {
        VStack {
            Text("Temperature: \(String(format: "%.2f", bleManager.temperatures.last ?? 0.0)) °C") // Display the last temperature in the array
                .padding()

            List(bleManager.temperatures, id: \.self) { temperature in
                Text("\(String(format: "%.2f", temperature)) °C")
            }
            .padding()
        }
    }
}
