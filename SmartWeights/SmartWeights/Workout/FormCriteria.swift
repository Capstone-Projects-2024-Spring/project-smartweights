//
//  FormCriteria.swift
//  SmartWeights
//
//  Created by Tu Ha on 4/4/24.
//

import SwiftUI


class FormCriteria: ObservableObject{
    
    /*
    read from the arrays that store the data
    
    calculate the form for one set (speed)
        
     */

    //read the Zaxis rotation
    //make a function that reads from array
    func averageUpDownAcceleration(array: [[Int]]) -> Double{

        /*
        good acceleration for going up and down -180°/s, 180°/s
        bad - less than -180 or greater than 180
        */
        var count = 0
        var good = 0
        var fast = 0

        array.forEach { (data) in
            if data[2] > -180 && data[2] < 180{
                good += 1
            }
            else if data[2] < 0{
                fast += 1
            }
            count += 1
        }

        return Double(good)/Double(count)
        
    }
    //tell the user if they going going up too fast or going down too fast
    func UpDownAcceleration(array: [[Int]]) -> (Double,Double){
        
        var tooFastUp = 0
        var tooFastDown = 0
        
        var upCount = 0
        var downCount = 0
        
        array.forEach{ (data) in
            
            if data[2] > 180{
                tooFastUp += 1
            }
            else if data[2] < -180{
                tooFastDown += 1
            }
            
            if data[2] > 0{
                upCount += 1
            }
            else if data[2] < 0{
                downCount += 1
            }

        }
        
        return(Double(tooFastUp)/Double(upCount), Double(tooFastDown)/Double(downCount))
        
    }
    
    func giveFeedback(array: [[Int]]) -> (String,String,String){
    

        var overallAccel = "Overall acceleration: \(self.averageUpDownAcceleration(array: array)) %"
        var upSpeed = " \(self.UpDownAcceleration(array: array).0  * 100)% of your reps are too fast going up"
        var downSpeed = "\(self.UpDownAcceleration(array: array).1 * 100)% of your reps are too fast going down"
        
        return (overallAccel,upSpeed,downSpeed)
        
    }
    
}


struct FormCriteriaView:View {
    @ObservedObject var ble = BLEcentral()
    @ObservedObject var form = FormCriteria()
    
    @State var z = 0.0
    @State var up = 0.0
    @State var down = 0.0
    
    var body: some View {
        bleView(ble: ble)
        
        
        Button(action: {
            z = form.averageUpDownAcceleration(array: ble.MPU6050_1Gyros)
            up = form.UpDownAcceleration(array: ble.MPU6050_1Gyros).0
            down = form.UpDownAcceleration(array: ble.MPU6050_1Gyros).1
        }){
            Text("get feedback")
        }
        Text("Overall acceleration going up and down is \(z*100)%")
        Text("\(up * 100)% of your reps are too fast going up")
        Text("\(down * 100)% of your reps are too fast going down")
        
    
        
        
    }
}

#Preview{
    FormCriteriaView()
}
