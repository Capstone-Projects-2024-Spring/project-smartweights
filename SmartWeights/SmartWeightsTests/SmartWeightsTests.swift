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
    
    //testing adding data into the progress bar on StartWorkout.swift
    func testWorkoutViewModelAddProgress(){
        //given
        let viewModel = WorkoutViewModel()
    
        //when
        viewModel.progress = 0
        let data = 0.75
        viewModel.addProgress(data: data)
        
    
        //then
        let expectedProgress = 0.75

        
        
        XCTAssertEqual(viewModel.progress,expectedProgress)
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
        
        
        XCTAssertEqual(viewModel.progress,expectedResetProgress)
    }
    
    //testing the workout timer on StartWorkout.swift
    func testWorkoutTimer() {
        // Given
        let viewModel = WorkoutViewModel()
        let expectation = XCTestExpectation(description: "Timer stops after 2 seconds")

        // When
        viewModel.startTimer()
        viewModel.seconds = 0
        let seconds = 2
        // Schedule the function call after the delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            viewModel.stopTimer()
            expectation.fulfill()
        }

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 2.0)

        // Then
        XCTAssertEqual(viewModel.seconds, seconds)
    }
    
    // test if store will sort all items by name
        func testSortItemsByName() {
            // Given
            let viewModel = storeViewModel()
            let items = viewModel.items
            
            // When
            let sortedItems = viewModel.sortItems(items: items, sortByPrice: false)
            
            // Then
            XCTAssertEqual(sortedItems.map { $0.name }, ["Apple", "Cat", "Dinosaur", "Dog", "Flag", "Floral Glasses", "Jetpack", "Juice", "Orange", "Pet Chain", "Sand Castle"])
        }
        
        // test if store will sort all items by price
        func testSortItemsByPrice() {
            // Given
            let viewModel = storeViewModel()
            let items = viewModel.items
            
            // When
            let sortedItems = viewModel.sortItems(items: items, sortByPrice: true)
            
            // Then
            XCTAssertEqual(sortedItems.map { $0.name }, ["Orange", "Juice", "Apple", "Flag", "Sand Castle", "Floral Glasses", "Pet Chain", "Jetpack", "Cat", "Dog", "Dinosaur"])
        }
}
