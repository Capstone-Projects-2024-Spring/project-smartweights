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
     */
    //dumbbell averages
    private var listOfDumbellAverage:[Double] = []
    private var listOfWristLeftRightAverage:[Double] = []
    private var listOfWristUpDownAverage:[Double] = []
    
    
    //elbow averages
    private var listOfElbowSwingAverage:[Double] = []
    private var listOfElbowFlareUpDwonAverage:[Double] = []
    private var listOfElbowFlareForwardBackAverage: [Double] = []
    
    
    //phrases
    private var goodFormPhrases: [String] = ["Keep up the good work!!","Looking good","Phew, Good job","Those curls were nice!"]
    
    func getRandomGoodFormPhrase() -> String {
        let randomIndex = Int.random(in: 0..<goodFormPhrases.count)
        return goodFormPhrases[randomIndex]
    }
    
    
    
    
    //---------------------DUMBBELL-------------------//
    
    //read the Z axis rotation and gives an average of the up and down for that set
    func averageUpDownAcceleration(array: [[Int]]) -> Double{

        /*
        good acceleration for going up and down -180°/s, 180°/s
        bad - less than -180 or greater than 180
        */
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var fast = 0 // data outside of good form
        var percentage:Double = 0 //return

        array.forEach { (data) in
            if data[2] < 10 && data[2] > -10{ //the user isnt making a rep, could be between reps
                //ignore resting data
            }
            else if data[2] > -180 && data[2] < 180{ //between good threshhold
                good += 1
            }
            else{
                fast += 1 //data is outside range
            }
            //ignoring resting movements
            if data[2] > 10 || data[2] < -10{
                count += 1
            }
            
        }
        percentage = Double(good)/Double(count)
        self.listOfDumbellAverage.append(Double(good)/Double(count))
        return percentage
        
    }
    
    
    //twisting writst left and right
    func averageWristLeftRightRotation(array: [[Int]]) -> Double{
        
        //measurement from the X rotation
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var fast = 0 // data outside of good form
        var percentage:Double = 0 //return

        array.forEach { (data) in
            if data[0] < 10 && data[1] > -10{ //the user isnt making a rep, could be between reps
                //ignore resting data
            }
            else if data[0] > -20 && data[0] < 20{ //between good threshhold
                good += 1
            }
            else{
                fast += 1 //data is outside range
            }
            //ignoring resting movements
            if data[0] > 10 || data[0] < -10{
                count += 1
            }
            
        }
        percentage = Double(good)/Double(count)
        self.listOfWristLeftRightAverage.append(percentage)
        return percentage
        
    }
    
    //twisting up and down
    func averageWristUpDownRotation(array: [[Int]]) -> Double{
       
        //measurement from the Y rotation
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var fast = 0 // data outside of good form
        var percentage:Double = 0 //return

        array.forEach { (data) in
            if data[1] < 10 && data[1] > -10{ //the user isnt making a rep, could be between reps
                //ignore resting data
            }
            else if data[1] > -20 && data[1] < 20{ //between good threshhold
                good += 1
            }
            else{
                fast += 1 //data is outside range
            }
            //ignoring resting movements
            if data[1] > 10 || data[1] < -10{
                count += 1
            }
            
        }
        percentage = Double(good)/Double(count)
        self.listOfWristUpDownAverage.append(percentage)
        return percentage
        
        
        
        //get the average of each set and compute the overall average for the workout
        //(sum of averages from sets)/total sets
        func overallWorkoutUpDownAverage(totalSets: Int) -> Double {
            
            var sum = 0
            
            self.listOfDumbellAverage.forEach{ (data) in
                sum += Int(data)
            }
            
            return (Double(sum)/Double(totalSets))
            
        }
        
    }
    
    
    func overwallWorkoutTwisting(totalSets: Int)->(Double,Double){
        
        var sumUpDown = 0
        var sumLeftRight = 0
        var averageUpDown: Double = 0.0
        var averageLeftRight: Double = 0.0
        
        self.listOfWristUpDownAverage.forEach{ (data) in
            sumUpDown += Int(data)
            
        }
        averageUpDown = (Double(sumUpDown)/Double(totalSets))
        
        
        
        self.listOfWristLeftRightAverage.forEach{ (data) in
            sumLeftRight += Int(data)
            
        }
        
        averageLeftRight = (Double(sumLeftRight)/Double(totalSets))
        
        return (averageUpDown,averageLeftRight)
        
    }
    
    //--------------------------------ELBOW-------------------------------//
    
    //measures if the eblow is swinging back and forth too much
    //use MPU6050-2
    func averageElbowSwing(array: [[Int]]) -> Double {
        
        var count = 0 //total data collected
        var good = 0
        var tooMuchSwing = 0
        var percentage:Double = 0 //return
        
     
        //data[x,y,z]
        array.forEach { (data) in
            if data[0] < 10 && data[0] > -10{ //the user isnt making a rep, could be between reps
                //ignore it
            }
            else if data[0] > -50 && data[0] < 50{ //in good treshhold of elbow swing
                good += 1
            }
            else{
                tooMuchSwing += 1 //data is outside of range
            }
            if data[0] > 10 || data[0] < -10{ //only add when they are moving not resting
                count += 1
            }
            
        }
        percentage = Double(good)/Double(count)
        self.listOfElbowSwingAverage.append(percentage)
        return percentage
    }
    
    
    //flaring elbow up and down
    func averageEblowFlareUpDown(array: [[Int]]) -> Double {
        
        var count = 0 //total data collected
        var good = 0
        var tooMuchFlare = 0
        var percentage:Double = 0 //return
        
     
        //data[x,y,z]
        array.forEach { (data) in
            if data[2] < 10 && data[2] > -10{ //the user isnt making a rep, could be between reps
                //ignore it
            }
            else if data[2] > -20 && data[2] < 20{ //in good treshhold of elbow flare
                good += 1
            }
            else{
                tooMuchFlare += 1 //data is outside of range
            }
            if data[2] > 10 || data[2] < -10{ //only add when they are moving not resting
                count += 1
            }
            
        }
        percentage = Double(good)/Double(count)
        return percentage
    }
    
    
    
    //flaring elbow forward and black
    func averageEblowFlareFowardBackward(array: [[Int]]) -> Double {
        
        var count = 0 //total data collected
        var good = 0
        var tooMuchFlare = 0
        var percentage:Double = 0 //return
        
     
        //data[x,y,z]
        array.forEach { (data) in
            if data[2] < 10 && data[2] > -10{ //the user isnt making a rep, could be between reps
                //ignore it
            }
            else if data[2] > -20 && data[2] < 20{ //in good treshhold of elbow flare
                good += 1
            }
            else{
                tooMuchFlare += 1 //data is outside of range
            }
            if data[2] > 10 || data[2] < -10{ //only add when they are moving not resting
                count += 1
            }
            
        }
        percentage = Double(good)/Double(count)
        return percentage
    }
    
    
    
  

    //get average of elbow swinging for the workout
    
    func overallWorkoutElbowSwing(totalSets: Int) -> Double{
        
        var sum = 0
        
        self.listOfElbowSwingAverage.forEach{ (data) in
            sum += Int(data)
            
        }
        return Double(sum/totalSets)
    }
    
    
    
    func overallWorkoutElbowFlare() {
        
        
        
    }
    
    
    
    //----------------DANGEROUS MOVEMENTS----------------//
    
    //Threshhold if they are moving too fast and is dangerous
    func dangerousForm() -> (Bool,Bool){
        
        //if accel > 300 degrees per second
        //if the accel(300)/total count > 10% of the workout return true
        
        
        //if dangerous eblow movement or going too fast return true
        
        return (true,true)
    }
    
    
    
    //--------------FEEDBACK---------------------//
    
    //returns a tuple of strings for the specific feedback
    func giveFeedback(dumbbellArray: [[Int]],elbowArray: [[Int]] ) -> (String,String,String,String){
    
        let averageAcceleration = self.averageUpDownAcceleration(array: dumbbellArray)
        let averageElbowSwing = self.averageElbowSwing(array: elbowArray)
        

        let overallAccel = String(format: "Overall curl acceleration: %.f%% good", averageAcceleration * 100)
        let overallElbowSwing = String(format: "Overall elbow stability: %.f%% good", averageElbowSwing * 100)
        var dumbbellCustomTextFeedback = ""
        var elbowCustomTextFeedback = ""
        
        if averageAcceleration < 0.7{
            dumbbellCustomTextFeedback = "Whoa slow down!!"
            
        }
        else{
            //TODO: Make a array of phrases and randomize which one to be called
            dumbbellCustomTextFeedback = getRandomGoodFormPhrase()
        }
        
        if averageElbowSwing < 0.7{
            elbowCustomTextFeedback = "Keep those elbow steady!"
        }
        else{
            elbowCustomTextFeedback = "Elbows are looking good!!!"
        }
        
        //need to add when form is dangerous
        
        return (overallAccel,overallElbowSwing,dumbbellCustomTextFeedback,elbowCustomTextFeedback)
        
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
