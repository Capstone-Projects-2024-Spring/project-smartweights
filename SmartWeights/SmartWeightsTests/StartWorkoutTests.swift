//
//  StartWorkoutTests.swift
//  SmartWeightsTests
//
//  Created by Tu Ha on 4/27/24.
//

import XCTest
@testable import SmartWeights

class MockCoreDataManager: CoreDataManager {
    var fetchDataCalled = false
    var mockData: [Data] = [] // Add mock data as needed
    
    
    override func createExerciseSet(workoutSession: WorkoutSession, setNum: Int, avgCurlAcceleration: Double, avgElbowFlareLR: Double, avgElbowFlareUD: Double, avgElbowSwing: Double, avgWristStabilityLR: Double, avgWristStabilityUD: Double) -> ExerciseSet? {
        
        print("override")
        return nil
    }
}


final class StartWorkoutTests: XCTestCase {
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testIsInputZeroOrInvalid() {
        // Given
        var viewModel = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())

        // Test with valid inputs
        viewModel.inputtedSets = "3"
        viewModel.inputtedReps = "10"
        viewModel.inputtedWeights = "15"
        viewModel.inputtedCountdown = "5"
        
        // When
        let resultWithValidInputs = viewModel.isInputZeroOrInvalid()
        
        // Then
        XCTAssertFalse(resultWithValidInputs, "The result should be false as all inputs are valid.")
        
        // Test with invalid inputs
        viewModel.inputtedSets = "0"
        viewModel.inputtedReps = "  "
        viewModel.inputtedWeights = "0"
        viewModel.inputtedCountdown = ""
        
        // When
        let resultWithInvalidInputs = viewModel.isInputZeroOrInvalid()
        
        // Then
        XCTAssertTrue(resultWithInvalidInputs, "The result should be true as all inputs are invalid.")
    }
    
    func testIsValidInput() {
        // Given
        var viewModel = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())
        // Test with valid input
        let validInput = "3"
        
        // When
        let resultWithValidInput = viewModel.isValidInput(validInput)
        
        // Then
        XCTAssertTrue(resultWithValidInput, "The result should be true as the input is valid.")
        
        // Test with invalid inputs
        let invalidInput1 = "  "
        let invalidInput2 = "abc"
        
        // When
        let resultWithInvalidInput1 = viewModel.isValidInput(invalidInput1)
        let resultWithInvalidInput2 = viewModel.isValidInput(invalidInput2)
        
        // Then
        XCTAssertFalse(resultWithInvalidInput1, "The result should be false as the input is invalid.")
        XCTAssertFalse(resultWithInvalidInput2, "The result should be false as the input is invalid.")
    }

    func testStringToInt() {
        // Given
        var viewModel = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())

        // Test with valid input
        let validInput = "3"
        
        // When
        let resultWithValidInput = viewModel.stringToInt(validInput)
        
        // Then
        XCTAssertEqual(resultWithValidInput, 3, "The result should be 3 as the input is '3'.")
        
        // Test with invalid input
        let invalidInput = "abc"
        
        // When
        let resultWithInvalidInput = viewModel.stringToInt(invalidInput)
        
        // Then
        XCTAssertNil(resultWithInvalidInput, "The result should be nil as the input is invalid.")
    }
    
    func testResetWorkoutState() {
        // Given
        let startWorkout = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())
        startWorkout.countdownActive = true
        startWorkout.countdown = 10
        startWorkout.progress = 0.5
        startWorkout.inputtedSets = "5"
        startWorkout.inputtedReps = "10"
        startWorkout.inputtedWeights = "50"
        startWorkout.inputtedCountdown = "3"
        startWorkout.currentSets = 2
        
        // When
        startWorkout.resetWorkoutState()
        
        // Then
        XCTAssertFalse(startWorkout.countdownActive, "countdownActive should be false after reset.")
        XCTAssertEqual(startWorkout.countdown, 0, "countdown should be 0 after reset.")
        XCTAssertEqual(startWorkout.progress, 0, "progress should be 0 after reset.")
        XCTAssertEqual(startWorkout.inputtedSets, "", "inputtedSets should be empty after reset.")
        XCTAssertEqual(startWorkout.inputtedReps, "", "inputtedReps should be empty after reset.")
        XCTAssertEqual(startWorkout.inputtedWeights, "", "inputtedWeights should be empty after reset.")
        XCTAssertEqual(startWorkout.inputtedCountdown, "", "inputtedCountdown should be empty after reset.")
        XCTAssertEqual(startWorkout.currentSets, 0, "currentSets should be 0 after reset.")
        
    }

    
    func testStartWorkout() {
        // Given
        let startWorkout = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())
        startWorkout.inputtedSets = "5"
        startWorkout.inputtedReps = "10"
        startWorkout.inputtedWeights = "50"

        // When
        startWorkout.startWorkout()

        // Then
        XCTAssertEqual(startWorkout.WorkoutState, .started, "WorkoutState should be .started after calling startWorkout.")
    }
    
    func testNextSet() {
        // Given
        let startWorkout = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())
        startWorkout.showGraphPopover = true
        startWorkout.isWorkoutPaused = true
        startWorkout.ble.MPU6050_1Gyros = [[2,3,4]]
        startWorkout.ble.MPU6050_2Gyros = [[1,2,3]]
        startWorkout.ble.collectDataToggle = false
        startWorkout.isWorkingOut = false

        // When
        startWorkout.nextset()

        // Then
        XCTAssertEqual(startWorkout.WorkoutState, .started, "WorkoutState should be .started after calling nextset.")
        XCTAssertFalse(startWorkout.showGraphPopover, "showGraphPopover should be false after calling nextset.")
        XCTAssertFalse(startWorkout.isWorkoutPaused, "isWorkoutPaused should be false after calling nextset.")
        XCTAssertTrue(startWorkout.ble.MPU6050_1Gyros.isEmpty, "MPU6050_1Gyros should be empty after calling nextset.")
        XCTAssertTrue(startWorkout.ble.MPU6050_2Gyros.isEmpty, "MPU6050_2Gyros should be empty after calling nextset.")
        XCTAssertTrue(startWorkout.ble.collectDataToggle, "collectDataToggle should be true after calling nextset.")
        XCTAssertEqual(startWorkout.currentMotivationalPhrase, "You're doing great!", "currentMotivationalPhrase should be set correctly after calling nextset.")
        XCTAssertTrue(startWorkout.isWorkingOut, "isWorkingOut should be true after calling nextset.")
    }
    
    func testResetTimer() {
        
            let startWorkout = WorkoutViewModel(ble: BLEcentral(), formCriteria: FormCriteria(), coreDataManager: MockCoreDataManager())
        
            // Given
            startWorkout.hours = 1
            startWorkout.minutes = 1
            startWorkout.seconds = 1
            startWorkout.timerIsActive = true

            // When
            startWorkout.resetTimer()

            // Then
            XCTAssertEqual(startWorkout.hours, 0, "Hours should be reset to 0.")
            XCTAssertEqual(startWorkout.minutes, 0, "Minutes should be reset to 0.")
            XCTAssertEqual(startWorkout.seconds, 0, "Seconds should be reset to 0.")
            XCTAssertFalse(startWorkout.timerIsActive, "timerIsActive should be false after reset.")
        }


}
