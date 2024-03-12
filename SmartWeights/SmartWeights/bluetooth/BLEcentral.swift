

import SwiftUI
import CoreBluetooth


class BluetoothViewModel: NSObject, ObservableObject{
    
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    
    @Published var peripheralNames: [String] = []
    
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }

}

extension BluetoothViewModel: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn{
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral){
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unamed device")
        }
    }
}

struct BLEview: View{
    
    @ObservedObject private var BLEviewModel = BluetoothViewModel()
    
    
    var body: some View{
        
        NavigationView{
            List(BLEviewModel.peripheralNames, id: \.self){
                peripheral in Text(peripheral)
            }
            .navigationTitle("Peripherals")
        }
    }
}


#Preview {
    BLEview()
}


