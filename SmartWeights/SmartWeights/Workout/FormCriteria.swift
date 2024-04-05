//
//  FormCriteria.swift
//  SmartWeights
//
//  Created by Tu Ha on 4/4/24.
//

import SwiftUI


class FormCriteria: ObservableObject{

    var ble: BLEcentral
    @Published var xhighLow: (Int, Int) = (0, 0)
    @Published var yhighLow: (Int, Int) = (0, 0)
    @Published var zhighLow: (Int, Int) = (0, 0)

    init(ble: BLEcentral) {
        self.ble = ble
    }

    func updateHighLow() {
        xhighLow = xRotationHighLow
        yhighLow = yRotationHighLow
        zhighLow = zRotationHighLow
    }
    
    //returns the high and low of X rotation
    
    var xRotationHighLow: (Int, Int) {
        var low = 0
        var high = 0

        for data in ble.MPU6050_1Gyros {
            if data[0] < low {
                low = data[0]
            }
            else if data[0] > high {
                high = data[0]
            }
        }
        return (high, low)
    }
    


    
    //returns the high and low of Y rotation

    var yRotationHighLow: (Int, Int) {
        var low = 0
        var high = 0

        for data in ble.MPU6050_1Gyros {
            if data[1] < low {
                low = data[1]
            }
            else if data[1] > high {
                high = data[1]
            }
        }
        return (high, low)
    }

    //returns the high and low of Z rotation

    var zRotationHighLow: (Int, Int) {
        var low = 0
        var high = 0

        for data in ble.MPU6050_1Gyros {
            if data[2] < low {
                low = data[2]
            }
            else if data[2] > high {
                high = data[2]
            }
        }
        return (high, low)
    }
    
}

struct FormCriteriaView: View {
    @ObservedObject var HighLow = FormCriteria(ble: BLEcentral())

    var body: some View {
        VStack {
            bleView()

            VStack {
                Text("X Rotation High: \(HighLow.xhighLow.0) Low: \(HighLow.xhighLow.1)")
                Text("Y Rotation High: \(HighLow.yhighLow.0) Low: \(HighLow.yhighLow.1)")
                Text("Z Rotation High: \(HighLow.zhighLow.0) Low: \(HighLow.zhighLow.1)")
            }

            Button(action: {
                HighLow.updateHighLow()
            }) {
                Text("Update")
            }
        }
    }
}
#Preview {
    FormCriteriaView()
}
