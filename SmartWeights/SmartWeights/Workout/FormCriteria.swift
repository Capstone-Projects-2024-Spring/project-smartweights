//
//  FormCriteria.swift
//  SmartWeights
//
//  Created by Tu Ha on 4/4/24.
//

import SwiftUI

/// `FormCriteria` is a class that contains the criteria for determining the form of the user during a workout.
class FormCriteria: ObservableObject{
    
    //dumbbell averages
    var listOfDumbbellAverage:[Double] = []
    var listOfWristLeftRightAverage:[Double] = []
    var listOfWristUpDownAverage:[Double] = []
    
    
    //elbow averages
    var listOfElbowSwingAverage:[Double] = []
    var listOfElbowFlareUpDownAverage:[Double] = []
    var listOfElbowFlareForwardBackAverage: [Double] = []
    
    
    var dumbbellDangerousCheck:[[Int]] = []
    var elbowDangerousCheck: [[Int]] = []
    
    
    //phrases
    var goodFormPhrases: [String] = ["Keep up the good work!!","Beautiful curls!","Phew, good job","Those curls were nice!","I'm proud of you"]
    /// 
    /// - Returns: A random phrase from the list of good form phrases.
    func getRandomGoodFormPhrase() -> String {
        let randomIndex = Int.random(in: 0..<goodFormPhrases.count)
        return goodFormPhrases[randomIndex]
    }
    /// `resetListofData` is a function that clears the data for the next workout.
    ///
    /// This function removes all elements from the following lists:
    /// - `listOfDumbbellAverage`
    /// - `listOfWristUpDownAverage`
    /// - `listOfWristLeftRightAverage`
    /// - `listOfElbowSwingAverage`
    /// - `listOfElbowFlareUpDownAverage`
    /// - `listOfElbowFlareForwardBackAverage`
    ///
    /// After clearing the data, it prints a message to the console.
    ///
    /// - Note: This function should be called before starting a new workout to ensure that the data from the previous workout does not affect the new one.
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
    
    /// `UpdateWorkoutAnalysis` is a function that updates the workout analysis based on the data collected during the workout.
    /// - Parameters:
    ///   - totalSets:Int
    ///   - dumbbellArray: 
    ///   - elbowArray: 
    /// - Returns: A dictionary containing the workout analysis.
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
        workoutAnalysis["averageElbowFlareForwardBackward"] = averageElbowFlareForwardBackward(array: elbowArray) * 100
        workoutAnalysis["overallWorkoutElbowSwing"] = overallWorkoutElbowSwing(totalSets: totalSets) * 100
        workoutAnalysis["overallWorkoutElbowFlareUpDown"] = overallWorkoutElbowFlare(totalSets: totalSets).0 * 100
        workoutAnalysis["overallWorkoutElbowFlareForwardBackward"] = overallWorkoutElbowFlare(totalSets: totalSets).1 * 100
        return workoutAnalysis
    }
    
    
    
    
    
    //---------------------DUMBBELL-------------------//
    

    /// `averageUpDownAcceleration` is a function that calculates the average up and down acceleration of the dumbbell during a set.
    /// - Parameters:
    ///  - array: An array of arrays containing the x, y, and z acceleration data of the dumbbell.
    /// - append: A boolean value that determines whether to append the data to the list of dumbbell averages.
    /// - Returns: The percentage of good form for the up and down acceleration of the dumbbell.

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
    
    /// `averageWristLeftRightRotation` is a function that calculates the average left and right rotation of the wrist during a set.
    /// - Parameters:
    /// - array: An array of arrays containing the x, y, and z rotation data of the wrist.
    /// - Returns: The percentage of good form for the left and right rotation of the wrist.
    
    //twisting wrist left and right
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

    /// `averageWristUpDownRotation` is a function that calculates the average up and down rotation of the wrist during a set.
    /// - Parameters:
    /// - array: An array of arrays containing the x, y, and z rotation data of the wrist.
    /// - Returns: The percentage of good form for the up and down rotation of the wrist.
    
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
    
    
    /// `overallWorkoutUpDownAverage` is a function that calculates the overall average of the up and down acceleration of the dumbbell for the entire workout.
    /// - Parameters:
    /// - totalSets: The total number of sets in the workout.
    /// - Returns: The percentage of good form for the up and down acceleration of the dumbbell for the entire workout.

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
    
    
    /// `overallDumbbellTwisting` is a function that calculates the overall average of the left and right and up and down rotation of the wrist for the entire workout.
    /// - Parameter totalSets: 
    /// - Returns: A tuple containing the average up and down rotation of the wrist and the average left and right rotation of the wrist for the entire workout.
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
    
    /// `averageElbowSwing` is a function that calculates the average elbow swing of the user during a set.
    /// - Parameters: 
    /// - array: An array of arrays containing the x, y, and z rotation data of the elbow.
    /// - append: A boolean value that determines whether to append the data to the list of elbow averages.
    /// - Returns: The percentage of good form for the elbow swing.
    //measures if the elbow is swinging back and forth too much
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
    
    /// `averageElbowFlareUpDown` is a function that calculates the average elbow flare of the user during a set.
    /// - Parameters:
    /// - array: An array of arrays containing the x, y, and z rotation data of the elbow.
    /// - Returns: The percentage of good form for the elbow flare.
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
    
    
    /// `averageElbowFlareForwardBackward` is a function that calculates the average elbow flare of the user during a set.
    /// - Parameters:
    /// - array: An array of arrays containing the x, y, and z rotation data of the elbow.
    /// - Returns: The percentage of good form for the elbow flare.
    //flaring elbow forward and black
    func averageElbowFlareForwardBackward(array: [[Int]]) -> Double {
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
    
    /// `overallWorkoutElbowSwing` is a function that calculates the overall average of the elbow swing for the entire workout.
    /// - Parameters:
    /// - totalSets: The total number of sets in the workout.
    /// - Returns: The percentage of good form for the elbow swing for the entire workout.
    
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
    
    /// `overallWorkoutElbowFlare` is a function that calculates the overall average of the elbow flare for the entire workout.
    /// - Parameters:
    /// - totalSets: The total number of sets in the workout.
    /// - Returns: A tuple containing the average up and down elbow flare and the average forward and backward elbow flare for the entire workout.
    
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
    
    /// `dangerousForm` is a function that checks if the user is moving too fast and is in a dangerous position.
    /// - Parameters:
    /// - dumbbellData: An array containing the x, y, and z acceleration data of the dumbbell.
    /// - elbowData: An array containing the x, y, and z rotation data of the elbow.
    /// - Returns: A boolean value indicating whether the user is in a dangerous position.

    //Threshold if they are moving too fast and is dangerous
    //will be ran in a while loop to continuously check the user
    func dangerousForm(dumbbellData:[Int], elbowData: [Int]) -> Bool{
        //300 degrees per second is the dangerous threshold

        //returns true if any of the data is greater than 300
        return (dumbbellData[0] >= 500 || dumbbellData[1] >= 500 || dumbbellData[2] >= 500 || elbowData[0] >= 300 || elbowData[1] >= 300 || elbowData[2] >= 300)

    }
    
    //--------------FEEDBACK---------------------//

    /// `giveFeedback` is a function that provides feedback to the user based on the data collected during the workout.
    /// - Parameters:
    /// - dumbbellArray: An array of arrays containing the x, y, and z acceleration data of the dumbbell.
    /// - elbowArray: An array of arrays containing the x, y, and z rotation data of the elbow.
    /// - Returns: A tuple of strings containing the feedback for the user.

    
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

