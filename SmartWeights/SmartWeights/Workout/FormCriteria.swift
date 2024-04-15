//
//  FormCriteria.swift
//  SmartWeights
//
//  Created by Tu Ha on 4/4/24.
//

import SwiftUI


class FormCriteria: ObservableObject{
    
    //dumbbell averages
    private var listOfDumbbellAverage:[Double] = []
    private var listOfWristLeftRightAverage:[Double] = []
    private var listOfWristUpDownAverage:[Double] = []
    
    
    //elbow averages
    private var listOfElbowSwingAverage:[Double] = []
    private var listOfElbowFlareUpDownAverage:[Double] = []
    private var listOfElbowFlareForwardBackAverage: [Double] = []
    
    
    private var dumbbellDangerousCheck:[[Int]] = []
    private var elbowDangerousCheck: [[Int]] = []
    
    
    //phrases
    private var goodFormPhrases: [String] = ["Keep up the good work!!","Looking good","Phew, Good job","Those curls were nice!"]
    
    func getRandomGoodFormPhrase() -> String {
        let randomIndex = Int.random(in: 0..<goodFormPhrases.count)
        return goodFormPhrases[randomIndex]
    }
    
    func resetListofData(){
        listOfDumbbellAverage.removeAll()
        listOfDumbbellAverage.removeAll()
        
    }
    
    
    
    
    //--------------------ALL_DATA--------------------//
    
    @State var workoutAnalysis: [String: Double] = [
        "averageUpDownAcceleration": 0.0,
        "averageWristLeftRightRotation": 0.0,
        "averageWristUpDownRotation": 0.0,
        "overallWorkoutUpDownAverage": 0.0,
        "overallDumbbellTwistingUpDown": 0.0,
        "overallDumbbellTwistingLeftRight": 0.0,
        "averageElbowSwing": 0.0,
        "averageElbowFlareUpDown": 0.0,
        "averageElbowFlareForwardBackward": 0.0,
        "overallWorkoutElbowSwing": 0.0,
        "overallWorkoutElbowFlareUpDown": 0.0,
        "overallWorkoutElbowFlareForwardBackward": 0.0
    ]
    
    
    func UpdateWorkoutAnalysis(totalSets:Int,dumbbellArray: [[Int]],elbowArray: [[Int]]){
        
        self.workoutAnalysis["averageUpDownAcceleration"] = averageUpDownAcceleration(array: dumbbellArray)
        self.workoutAnalysis["averageWristLeftRightRotation"] = averageWristLeftRightRotation(array: dumbbellArray)
        self.workoutAnalysis["averageWristUpDownRotation"] = averageWristUpDownRotation(array: dumbbellArray)
        self.workoutAnalysis["overallWorkoutUpDownAverage"] = overallWorkoutUpDownAverage(totalSets: totalSets)
        self.workoutAnalysis["overallDumbbellTwistingUpDown"] = overallDumbbellTwisting(totalSets: totalSets).0
        self.workoutAnalysis["overallDumbbellTwistingLeftRight"] = overallDumbbellTwisting(totalSets: totalSets).1
        self.workoutAnalysis["averageElbowSwing"] = averageElbowSwing(array: elbowArray)
        self.workoutAnalysis["averageElbowFlareUpDown"] = averageElbowFlareUpDown(array: elbowArray)
        self.workoutAnalysis["averageElbowFlareForwardBackward"] = averageElbowFlareFowardBackward(array: elbowArray)
        self.workoutAnalysis["overallWorkoutElbowSwing"] = overallWorkoutElbowSwing(totalSets: totalSets)
        self.workoutAnalysis["overallWorkoutElbowFlareUpDown"] = overallWorkoutElbowFlare(totalSets: totalSets).0
        self.workoutAnalysis["overallWorkoutElbowFlareForwardBackward"] = overallWorkoutElbowFlare(totalSets: totalSets).1
        
    }
    
    
    
    
    
    //---------------------DUMBBELL-------------------//
    
    //read the Z axis rotation and gives an average of the up and down for that set
    func averageUpDownAcceleration(array: [[Int]]) -> Double {
        /*
        good acceleration for going up and down -180°/s, 180°/s
        bad - less than -180 or greater than 180
        */
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 0 //return

        array.forEach { (data) in
            if data[2] < 10 && data[2] > -10 { //the user isn't making a rep, could be between reps
                //ignore resting data
            }
            else if data[2] > -180 && data[2] < 180 { //between good threshold
                good += 1
            }
            //ignoring resting movements
            if data[2] > 10 || data[2] < -10 {
                count += 1
            }
        }

        if count != 0 {
            percentage = Double(good) / Double(count)
            self.listOfDumbbellAverage.append(percentage)
        }

        return percentage
    }
    
    
    //twisting writst left and right
    func averageWristLeftRightRotation(array: [[Int]]) -> Double {
        //measurement from the X rotation
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 0 //return

        array.forEach { (data) in
            if data[0] < 10 && data[1] > -10 { //the user isnt making a rep, could be between reps
                //ignore resting data
            }
            else if data[0] > -20 && data[0] < 20 { //between good threshold
                good += 1
            }
            //ignoring resting movements
            if data[0] > 10 || data[0] < -10 {
                count += 1
            }
        }

        if count != 0 {
            percentage = Double(good) / Double(count)
            self.listOfWristLeftRightAverage.append(percentage)
        }

        return percentage
    }
    
    //twisting up and down
    func averageWristUpDownRotation(array: [[Int]]) -> Double {
        //measurement from the Y rotation
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 0 //return

        array.forEach { (data) in
            if data[1] < 10 && data[1] > -10 { //the user isn't making a rep, could be between reps
                //ignore resting data
            }
            else if data[1] > -20 && data[1] < 20 { //between good threshold
                good += 1
            }
            //ignoring resting movements
            if data[1] > 10 || data[1] < -10 {
                count += 1
            }
        }

        if count != 0 {
            percentage = Double(good) / Double(count)
            self.listOfWristUpDownAverage.append(percentage)
        }

        return percentage
    }
        
        
        
        //get the average of each set and compute the overall average for the workout
        //(sum of averages from sets)/total sets
    func overallWorkoutUpDownAverage(totalSets: Int) -> Double {
        guard totalSets != 0 else {
            return 0.0
        }

        var sum: Double = 0

        self.listOfDumbbellAverage.forEach { (data) in
            sum += data
        }

        return sum / Double(totalSets)
    }
        
    
    
    func overallDumbbellTwisting(totalSets: Int) -> (Double, Double) {
        guard totalSets != 0 else {
            return (0.0, 0.0)
        }

        var sumUpDown: Double = 0
        var sumLeftRight: Double = 0

        self.listOfWristUpDownAverage.forEach { (data) in
            sumUpDown += data
        }

        self.listOfWristLeftRightAverage.forEach { (data) in
            sumLeftRight += data
        }

        let averageUpDown = sumUpDown / Double(totalSets)
        let averageLeftRight = sumLeftRight / Double(totalSets)

        return (averageUpDown, averageLeftRight)
    }
    
    //--------------------------------ELBOW-------------------------------//
    
    //measures if the eblow is swinging back and forth too much
    //use MPU6050-2
    func averageElbowSwing(array: [[Int]]) -> Double {
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 0 //return

        //data[x,y,z]
        array.forEach { (data) in
            if data[0] < 10 && data[0] > -10 { //the user isn't making a rep, could be between reps
                //ignore it
            }
            else if data[0] > -50 && data[0] < 50 { //in good threshold of elbow swing
                good += 1
            }
            if data[0] > 10 || data[0] < -10 { //only add when they are moving not resting
                count += 1
            }
        }

        if count != 0 {
            percentage = Double(good) / Double(count)
            self.listOfElbowSwingAverage.append(percentage)
        }

        return percentage
    }
    
    
    //flaring elbow up and down
    func averageElbowFlareUpDown(array: [[Int]]) -> Double {
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 0 //return

        //data[x,y,z]
        array.forEach { (data) in
            if data[2] < 10 && data[2] > -10 { //the user isn't making a rep, could be between reps
                //ignore it
            }
            else if data[2] > -20 && data[2] < 20 { //in good threshold of elbow flare
                good += 1
            }
            if data[2] > 10 || data[2] < -10 { //only add when they are moving not resting
                count += 1
            }
        }

        if count != 0 {
            percentage = Double(good) / Double(count)
        }

        return percentage
    }
    
    
    
    //flaring elbow forward and black
    func averageElbowFlareFowardBackward(array: [[Int]]) -> Double {
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 0 //return

        //data[x,y,z]
        array.forEach { (data) in
            if data[2] < 10 && data[2] > -10 { //the user isn't making a rep, could be between reps
                //ignore it
            }
            else if data[2] > -20 && data[2] < 20 { //in good threshold of elbow flare
                good += 1
            }
            if data[2] > 10 || data[2] < -10 { //only add when they are moving not resting
                count += 1
            }
        }

        if count != 0 {
            percentage = Double(good) / Double(count)
        }

        return percentage
    }
    
    
    
    //get average of elbow swinging for the workout
    
    func overallWorkoutElbowSwing(totalSets: Int) -> Double {
        guard totalSets != 0 else {
            return 0.0
        }

        var sum: Double = 0

        self.listOfElbowSwingAverage.forEach { (data) in
            sum += data
        }

        return sum / Double(totalSets)
    }
    
    
    //gives the overall elbow flaring for the whole workout
    func overallWorkoutElbowFlare(totalSets: Int) -> (Double, Double) {
        guard totalSets != 0 else {
            return (0.0, 0.0)
        }

        var sumUpDown: Double = 0
        var sumForwardBackward: Double = 0

        self.listOfElbowFlareUpDownAverage.forEach { (data) in
            sumUpDown += data
        }

        self.listOfElbowFlareForwardBackAverage.forEach { (data) in
            sumForwardBackward += data
        }

        let averageUpDown = sumUpDown / Double(totalSets)
        let averageForwardBackward = sumForwardBackward / Double(totalSets)

        return (averageUpDown, averageForwardBackward)
    }

    
    
    
    //----------------DANGEROUS MOVEMENTS----------------//
    
    //Threshold if they are moving too fast and is dangerous
    //will be ran in a while loop to continuously check the user
    func dangerousForm(dumbbellArray:[[Int]], elbowArray: [[Int]]) -> Bool{
        
        //count all the data that is being collected
        var dumbbellSwingCount = 0
        var wristTwistLRcount = 0
        var wristTwistUDcount = 0
        var elbowSwingCount = 0
        var elbowFlareLRcount = 0
        var elbowFlareUPcount = 0
        
        //count how many data is in the dangerous threshold
        var dumbbellSwingDanger = 0
        var wristTwistLRdanger = 0
        var wristTwistUDdanger = 0
        var elbowSwingDanger = 0
        var elbowFlareLRdanger = 0
        var elbowFlareUPdanger = 0
        
        
        
        dumbbellArray.forEach{ (data) in
            //wristLR
            if abs(data[0]) > 100{
                wristTwistLRdanger += 1
            }
            
            if abs(data[1]) > 100 {
                wristTwistUDdanger += 1
            }
            
            if abs(data[2]) > 300 {
                dumbbellSwingDanger += 1
            }
            
            if abs(data[0]) > 10 {
                wristTwistLRcount  += 1
            }
            
            if abs(data[1]) > 10 {
                wristTwistUDcount += 1
            }

            if abs(data[2]) > 10 {
                dumbbellSwingCount += 1
            }
        }

        elbowArray.forEach { (data) in
            if abs(data[0]) > 200{
                elbowSwingDanger += 1
            }
            
            if abs(data[1]) > 200 {
                elbowFlareLRdanger += 1
            }
            
            if abs(data[2]) > 200 {
                elbowFlareUPdanger += 1
            }
            
            if abs(data[0]) > 10 {
                elbowSwingCount += 1
            }
            
            if abs(data[1]) > 10 {
                elbowFlareLRcount += 1
            }
            
            if abs(data[2]) > 10 {
                elbowFlareUPcount += 1
            }

        }
        
        
        let isDumbbellSwingDangerous = Double(dumbbellSwingDanger) / Double(dumbbellSwingCount) >= 0.1
        let isWristTwistLRDangerous = Double(wristTwistLRdanger) / Double(wristTwistLRcount) >= 0.1
        let isWristTwistUDDangerous = Double(wristTwistUDdanger) / Double(wristTwistUDcount) >= 0.1
        let isElbowSwingDangerous = Double(elbowSwingDanger) / Double(elbowSwingCount) >= 0.1
        let isElbowFlareLRDangerous = Double(elbowFlareLRdanger) / Double(elbowFlareLRcount) >= 0.1
        let isElbowFlareUPDangerous = Double(elbowFlareUPdanger) / Double(elbowFlareUPcount) >= 0.1
    

        let dangerous = isDumbbellSwingDangerous || isWristTwistLRDangerous || isWristTwistUDDangerous || isElbowSwingDangerous || isElbowFlareLRDangerous || isElbowFlareUPDangerous
        
        //TODO: show dangerous movements be returning a tuple of bool or just one bool
        //should I specify which movement is dangerous or just give overall dangerous activity
        
        return dangerous //returns Dumbbell Swing, Wrist twist, Elbow Swing, Elbow Flare
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
    
       
        Button(action: {
            form.UpdateWorkoutAnalysis(totalSets: 2, dumbbellArray: ble.MPU6050_1Gyros, elbowArray: ble.MPU6050_1Gyros)
        }) {
            Text("Update Workout Analysis")
        }
        Text("\(form.workoutAnalysis)")
    
        
        
    }
}

#Preview{
    FormCriteriaView()
}
