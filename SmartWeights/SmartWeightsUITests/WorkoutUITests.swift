//
//  WorkoutUITests.swift
//  SmartWeightsUITests
//
//  Created by Tu Ha on 2/29/24.
//
import XCTest

final class WorkoutUITests: XCTestCase {
    
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Clean up any resources if needed
    }
    
    
    
    
    //WORKOUT MAIN PAGE
    
    func testDatePicker() throws {
        //        let datePicker = app.datePickers["WorkoutDatePicker"]
        //
        //                // When: Select a date programmatically
        //                let selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())! // Set the desired date
        //                datePicker.setDate(selectedDate)
        //                
        //                // Then: Assert that the selected date is correct
        //                XCTAssertEqual(datePicker.date, selectedDate)
    }
    
    func testMicWorkoutButton(){
        
        let micWorkout = app.buttons["micWorkoutButton"]
        micWorkout.tap()
        
        XCTAssertTrue(micWorkout.exists)
    }
    
    func testStartWorkoutButton(){
        let micWorkout = app.buttons["micWorkoutButton"]
        micWorkout.tap()
        let startWorkout = app.buttons["startWorkoutButton"]
        startWorkout.tap()
        
        XCTAssertTrue(startWorkout.exists)
    }
    
    func testEndWorkoutButton(){
        let micWorkout = app.buttons["micWorkoutButton"]
        micWorkout.tap()
        let endWorkout = app.buttons["endWorkoutButton"]
        endWorkout.tap()
        
        XCTAssertTrue(endWorkout.exists)
    }
    
    
    
    
    
    
    //WORKOUT PROGRESS PAGE
    
    
}
