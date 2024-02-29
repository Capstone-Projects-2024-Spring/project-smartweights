//
//  SmartWeightsTests.swift
//  SmartWeightsTests
//
//  Created by Tu Ha on 2/12/24.
//

import XCTest
@testable import SmartWeights

final class SmartWeightsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    
    //WORKOUT MAIN PAGE
    
    
    //testing adding data into the progress bar on StartWorkout.swift
    func testWorkoutViewModelAddProgress(){
        //given
        let viewModel = WorkoutViewModel()
        let data = 0.75
        
        //when
        viewModel.progress = 0
        viewModel.addProgress(data: data)
        
        //then
        let expectedProgress = 0.75
        XCTAssertEqual(viewModel.progress,expectedProgress, "The expected progress should be 0.75 (75%)")
    }
    
    //testing reseting the progress bar on StartWorkout.swift
    func testWorkoutViewModelRestProgress(){
        //given
        let viewModel = WorkoutViewModel()
    
        //when
        viewModel.progress = 0.75
        viewModel.resetProgress()
        
    
        //then
        let expectedResetProgress = 0.0
        XCTAssertEqual(viewModel.progress,expectedResetProgress, "The progress should be set to 0")
    }
    
    //test that the timer can be reset in StartWorkout.swift
    func testResetTimer(){
        //Given
        let viewModel = WorkoutViewModel()
        
        viewModel.hours = 10
        viewModel.minutes = 20
        viewModel.seconds = 30000
        
        
        
        //When
        viewModel.restartTimer()
        
        //Then
        
        let expectedHours = 0
        let expectedMinutes = 0
        let expectedSeconds = 0
    
        XCTAssertEqual(viewModel.hours, expectedHours, "The hours should set back to 0")
        XCTAssertEqual(viewModel.minutes, expectedMinutes, "The minutes should set back to 0")
        XCTAssertEqual(viewModel.seconds, expectedSeconds, "The seconds should set back to 0")
    
    }
    
   
    
    //testing the workout timer on StartWorkout.swift
    func testWorkoutTimer() {
        // Given
        let viewModel = WorkoutViewModel()
        let expectation = XCTestExpectation(description: "Timer stops after 2 seconds")
       
        
        // When
        viewModel.startTimer()
        viewModel.seconds = 0
       
        // Schedule the function call after the delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            viewModel.stopTimer()
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)

        // Then
        let seconds = 2
        XCTAssertEqual(viewModel.seconds, seconds, "seconds should be displaying 2")
    }
    
    
   //WORKOUT PROGRESS PAGE
    
    //test that the date can be turned into the short format
    func testUpdateShortDate(){
        //Given
        let viewModel = OverallProgressViewModel()
        let date = Date()
        var shortDate = " "
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        shortDate = formatter.string(from: date)
        
        //When
        viewModel.updateShortDate()
        
        //Given
        XCTAssertEqual(viewModel.shortDate, shortDate, "The short date should be in the format M/D/Y")
        
    }
    
    
    

}
