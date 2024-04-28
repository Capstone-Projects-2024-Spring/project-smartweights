//
//  WorkoutUITests.swift
//  SmartWeightsUITests
//
//  Created by Par Chea on 04/27/24.
//

import XCTest
@testable import SmartWeights

class WorkoutMainPageTests: XCTestCase{
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testWorkoutStartsCorrectly() {
        // Assume that the Start Workout button has an accessibility label "StartWorkoutButton"
        let startWorkoutButton = app.buttons["StartWorkoutButton"]
        startWorkoutButton.tap()
        
        // Interact with the Sets text field
        let setsField = app.textFields[ "Sets"]
        setsField.tap()
        setsField.typeText("1") // Enter a valid number of sets
        
        // Interact with the Reps text field
        let repsField = app.textFields[ "Reps"]
        repsField.tap()
        repsField.typeText("1") // Enter a valid number of reps
        
        // Interact with the Weight text field
        let lbsField = app.textFields["Weight (lbs)"]
        lbsField.tap()
        lbsField.typeText("1") // Enter a valid weight in pounds
        
        
        let countdownTimer = app.textFields["Count down Timer (s)"]
        countdownTimer.tap()
        countdownTimer.typeText("5")

        // Tap the Start Workout button to submit details and start the workout
        let workoutDetailsStartButton = app.buttons["Start Workout"] // Assuming this is the button's identifier within the modal/pop-up
        workoutDetailsStartButton.tap()
        Thread.sleep(forTimeInterval: 8.0) // Sleeps the current thread for 5 seconds
        
        // Check if the motivational phrase has updated
        XCTAssert(app.staticTexts["First set, let's go!"].exists)
    }
    
    func testWorkoutInputInvalidate() {
        app.buttons["StartWorkoutButton"].tap()
        
        app.sheets.buttons["Enter Workout Details"].tap()
        // Assuming you have text fields with placeholders for workout details
        let setsField = app.textFields["Sets"]
        setsField.tap()
        setsField.typeText("abc") // Invalid input
        
        let startButton = app.buttons["Start Workout"]
        startButton.tap()
        // Check for an alert indicating invalid input
        XCTAssert(app.alerts["Invalid Input"].exists)
    }
    
    func testWorkoutInputValidation(){
        let startWorkoutButton = app.buttons["StartWorkoutButton"]
        startWorkoutButton.tap()
        
        // Interact with the Sets text field
        let setsField = app.textFields["Sets"]
        setsField.tap()
        setsField.typeText("1") // Enter a valid number of sets
        
        // Interact with the Reps text field
        let repsField = app.textFields[ "Reps"]
        repsField.tap()
        repsField.typeText("1") // Enter a valid number of reps
        
        // Interact with the Weight text field
        let lbsField = app.textFields[ "Weight (lbs) "]
        lbsField.tap()
        lbsField.typeText("1") // Enter a valid weight in pounds
        
        let countdownTimer = app.textFields["Count down Timer (s)"]
        countdownTimer.tap()
        countdownTimer.typeText("5")
        
        // Tap the Start Workout button to submit details and start the workout
        let workoutDetailsStartButton =
        app.buttons["Start Workout"] // Assuming this is the button's identifier within the modal/pop-up
        workoutDetailsStartButton.tap()
        
        Thread.sleep(forTimeInterval: 8.0) // Sleeps the current thread for 5 seconds
        // Assuming FinishSetButton is available after submitting the workout details and starting the workout
        
        let finishSetButton = app.buttons["FinishSetButton" ]
        finishSetButton.tap()
    }
    func testMicWorkoutButton(){
        let startWorkoutButton = app.buttons["StartWorkoutButton"]
        startWorkoutButton.tap()
        let micWorkout = app.buttons["Start Voice Command"]
        micWorkout.tap()
        XCTAssertTrue(micWorkout.exists)
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
}
