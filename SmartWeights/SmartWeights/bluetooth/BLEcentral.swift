

import SwiftUI
import CoreBluetooth


class BluetoothViewModel: NSObject, ObservableObject{
    
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    
    @Published var peripheralNames: [String] = []
    @Published var peripheralServices: [String] = []
    
    
    var connectedPeripheral: CBPeripheral?
    
    func connect(peripheral: CBPeripheral) {
        centralManager?.connect(peripheral, options: nil)
     }
    
    
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

        self.connectedPeripheral = peripheral
    }
    
    
}

struct BLEview: View{
    
    @ObservedObject private var BLEviewModel = BluetoothViewModel()
    
    
    var body: some View{
        HStack{
            NavigationView{
                List(BLEviewModel.peripheralNames, id: \.self){
                    peripheral in Text(peripheral)
                }
                .navigationTitle("Peripherals Names")
            }
            NavigationView{
                List(BLEviewModel.peripheralServices, id: \.self){
                    peripheral in Text(peripheral)
                }
                .navigationTitle("Peripherals Serivce")
            }
            
            
        }
    }
}


#Preview {
    BLEview()
}


