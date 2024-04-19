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
    private var goodFormPhrases: [String] = ["Keep up the good work!!","Beautiful curls!","Phew, good job","Those curls were nice!","I'm proud of you"]
    
    func getRandomGoodFormPhrase() -> String {
        let randomIndex = Int.random(in: 0..<goodFormPhrases.count)
        return goodFormPhrases[randomIndex]
    }
    
    func resetListofData(){
        listOfDumbbellAverage.removeAll()
        listOfWristUpDownAverage.removeAll()
        listOfWristLeftRightAverage.removeAll()
        listOfElbowSwingAverage.removeAll()
        listOfElbowFlareUpDownAverage.removeAll()
        listOfElbowFlareForwardBackAverage.removeAll()
        print("I am clearing the data for the next workout")
        
        
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
    
    
    func UpdateWorkoutAnalysis(totalSets:Int,dumbbellArray: [[Int]],elbowArray: [[Int]]) -> [String:Double]{
        var workoutAnalysis: [String:Double] = [:]
        workoutAnalysis["averageUpDownAcceleration"] = averageUpDownAcceleration(array: dumbbellArray, append: true) * 100
        workoutAnalysis["averageWristLeftRightRotation"] = averageWristLeftRightRotation(array: dumbbellArray) * 100
        workoutAnalysis["averageWristUpDownRotation"] = averageWristUpDownRotation(array: dumbbellArray) * 100
        workoutAnalysis["overallWorkoutUpDownAverage"] = overallWorkoutUpDownAverage(totalSets: totalSets) * 100
        workoutAnalysis["overallDumbbellTwistingUpDown"] = overallDumbbellTwisting(totalSets: totalSets).0 * 100
        workoutAnalysis["overallDumbbellTwistingLeftRight"] = overallDumbbellTwisting(totalSets: totalSets).1 * 100
        workoutAnalysis["averageElbowSwing"] = averageElbowSwing(array: elbowArray, append: true) * 100
        workoutAnalysis["averageElbowFlareUpDown"] = averageElbowFlareUpDown(array: elbowArray) * 100
        workoutAnalysis["averageElbowFlareForwardBackward"] = averageElbowFlareFowardBackward(array: elbowArray) * 100
        workoutAnalysis["overallWorkoutElbowSwing"] = overallWorkoutElbowSwing(totalSets: totalSets) * 100
        workoutAnalysis["overallWorkoutElbowFlareUpDown"] = overallWorkoutElbowFlare(totalSets: totalSets).0 * 100
        workoutAnalysis["overallWorkoutElbowFlareForwardBackward"] = overallWorkoutElbowFlare(totalSets: totalSets).1 * 100
        return workoutAnalysis
    }
    
    
    
    
    
    //---------------------DUMBBELL-------------------//
    
    //read the Z axis rotation and gives an average of the up and down for that set
    func averageUpDownAcceleration(array: [[Int]],append: Bool) -> Double {
        /*
        good acceleration for going up and down -180°/s, 180°/s
        bad - less than -180 or greater than 180
         */
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 1 //return
        
        array.forEach { (data) in
            if data[2] <= 10 && data[2] >= -10 { //the user isn't making a rep, could be between reps
                //ignore resting data
            }
            else if data[2] > -200 && data[2] < 200 { //between good threshold
                good += 1
            }
            //ignoring resting movements
            if data[2] > 10 || data[2] < -10 {
                count += 1
            }
        }
        
        if count != 0 {
            percentage = Double(good) / Double(count)
            
        }
        if append == true{
            self.listOfDumbbellAverage.append(percentage)
        }
        return percentage
    }
    
    
    //twisting writst left and right
    func averageWristLeftRightRotation(array: [[Int]]) -> Double {
        //measurement from the X rotation
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 1 //return
        
        array.forEach { (data) in
            if data[0] <= 10 && data[0] >= -10 { //the user isnt making a rep, could be between reps
                //ignore resting data
            }
            else if data[0] > -100 && data[0] < 100 { //between good threshold
                good += 1
            }
            //ignoring resting movements
            if data[0] > 10 || data[0] < -10 {
                count += 1
            }
        }
        
        if count != 0 {
            percentage = Double(good) / Double(count)
            
        }
        self.listOfWristLeftRightAverage.append(percentage)
        
        return percentage
    }
    
    //twisting up and down
    func averageWristUpDownRotation(array: [[Int]]) -> Double {
        //measurement from the Y rotation
        
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 1 //return
        
        array.forEach { (data) in
            if data[1] <= 10 && data[1] >= -10 { //the user isn't making a rep, could be between reps
                //ignore resting data
            }
            else if data[1] > -100 && data[1] < 100 { //between good threshold
                good += 1
            }
            //ignoring resting movements
            if data[1] > 10 || data[1] < -10 {
                count += 1
            }
        }
        
        if count != 0 {
            percentage = Double(good) / Double(count)
            
        }
        self.listOfWristUpDownAverage.append(percentage)
        
        return percentage
    }
    
    
    
    //get the average of each set and compute the overall average for the workout
    //(sum of averages from sets)/total sets
    func overallWorkoutUpDownAverage(totalSets: Int) -> Double {
        guard totalSets != 0 else {
            return 1.0
        }
        
        var sum: Double = 0
        
        self.listOfDumbbellAverage.forEach { (data) in
            sum += data
        }
        let percentage = sum/Double(totalSets)
        
        return percentage
    }
    
    
    
    func overallDumbbellTwisting(totalSets: Int) -> (Double, Double) {
        guard totalSets != 0 else {
            return (1.0, 1.0)
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
    func averageElbowSwing(array: [[Int]], append: Bool) -> Double {
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 1 //return
        
        //data[x,y,z]
        array.forEach { (data) in
            if data[0] <= 10 && data[0] >= -10 { //the user isn't making a rep, could be between reps
                //ignore it
            }
            else if data[0] > -100 && data[0] < 100 { //in good threshold of elbow swing
                good += 1
            }
            if data[0] > 10 || data[0] < -10 { //only add when they are moving not resting
                count += 1
            }
            
        }
        
        if count != 0 {
            percentage = Double(good) / Double(count)
            
        }
        if append == true{
            self.listOfElbowSwingAverage.append(percentage)
        }
        return percentage
    }
    
    
    //flaring elbow up and down
    func averageElbowFlareUpDown(array: [[Int]]) -> Double {
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 1 //return
        
        //data[x,y,z]
        array.forEach { (data) in
            if data[2] <= 10 && data[2] >= -10 { //the user isn't making a rep, could be between reps
                //ignore it
            }
            else if data[2] > -100 && data[2] < 100 { //in good threshold of elbow flare
                good += 1
            }
            if data[2] > 10 || data[2] < -10 { //only add when they are moving not resting
                count += 1
            }
        }
        
        if count != 0 {
            percentage = Double(good) / Double(count)
        }
        self.listOfElbowFlareUpDownAverage.append(percentage)
        return percentage
    }
    
    
    
    //flaring elbow forward and black
    func averageElbowFlareFowardBackward(array: [[Int]]) -> Double {
        var count = 0 //total data collected
        var good = 0 //data in range of good form
        var percentage: Double = 1 //return
        
        //data[x,y,z]
        array.forEach { (data) in
            if data[1] <= 10 && data[1] >= -10 { //the user isn't making a rep, could be between reps
                //ignore it
            }
            else if data[1] > -100 && data[1] < 100 { //in good threshold of elbow flare
                good += 1
            }
            if data[1] > 10 || data[1] < -10 { //only add when they are moving not resting
                count += 1
            }
        }
        
        if count != 0 {
            percentage = Double(good) / Double(count)
        }
        self.listOfElbowFlareForwardBackAverage.append(percentage)
        return percentage
    }
    
    
    
    //get average of elbow swinging for the workout
    
    func overallWorkoutElbowSwing(totalSets: Int) -> Double {
        guard totalSets != 0 else {
            return 1.0
        }
        
        var sum: Double = 0
        
        self.listOfElbowSwingAverage.forEach { (data) in
            sum += data
        }
        
        let percentage = sum/Double(totalSets)
        
        return percentage
    }
    
    
    //gives the overall elbow flaring for the whole workout
    func overallWorkoutElbowFlare(totalSets: Int) -> (Double, Double) {
        guard totalSets != 0 else {
            return (1.0, 1.0)
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
    func dangerousForm(dumbbellData:[Int], elbowData: [Int]) -> Bool{
        //300 degrees per second is the dangerous threshold

        //returns true if any of the data is greater than 300
        return (dumbbellData[0] >= 500 || dumbbellData[1] >= 500 || dumbbellData[2] >= 500 || elbowData[0] >= 300 || elbowData[1] >= 300 || elbowData[2] >= 300)

    }
    
    //--------------FEEDBACK---------------------//
    
    //returns a tuple of strings for the specific feedback
    func giveFeedback(dumbbellArray: [[Int]],elbowArray: [[Int]] ) -> (String,String,String,String){
        
        let averageAcceleration = self.averageUpDownAcceleration(array: dumbbellArray, append: false)
        let averageElbowSwing = self.averageElbowSwing(array: elbowArray, append: false)
        
        
        
        let overallAccel = String(format: "Curl acceleration: %.f%% good", averageAcceleration * 100)
        let overallElbowSwing = String(format: "Elbow stability: %.f%% good", averageElbowSwing * 100)
        var dumbbellCustomTextFeedback = ""
        var elbowCustomTextFeedback = ""
        
        if averageAcceleration < 0.7{
            dumbbellCustomTextFeedback = "Whoa slow down!!"
            
        }
        else{
            dumbbellCustomTextFeedback = getRandomGoodFormPhrase()
        }
        
        if averageElbowSwing < 0.7{
            elbowCustomTextFeedback = "Keep that elbow steady!"
        }
        else{
            elbowCustomTextFeedback = "Elbow is looking good!!!"
        }
        
        
        return (overallAccel,overallElbowSwing,dumbbellCustomTextFeedback,elbowCustomTextFeedback)
        
    }
    
}

