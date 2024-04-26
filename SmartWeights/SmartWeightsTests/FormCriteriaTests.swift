//
//  FormCriteria.swift
//  SmartWeightsTests
//
//  Created by Tu Ha on 4/26/24.
//

import XCTest
@testable import SmartWeights

final class FormCriteriaTests: XCTestCase {
    
    var formCriteria = FormCriteria()


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetRandomGoodFormPhrase() {
        // Given
        formCriteria.goodFormPhrases = ["Keep up the good work!!","Beautiful curls!","Phew, good job","Those curls were nice!","I'm proud of you"]
        
        // When
        let result = formCriteria.getRandomGoodFormPhrase()
        
        // Then
        // Check that the result is one of the good form phrases
        XCTAssertTrue(formCriteria.goodFormPhrases.contains(result), "The result should be one of the good form phrases.")
    }
    func testUpdateWorkoutAnalysis() {
        
        // Given
        let totalSets = 10
        let dumbbellArray = [[1, 2, 3], [4, 5, 6]]
        let elbowArray = [[7, 8, 9], [10, 11, 12]]
        
        
        // When
        let result = formCriteria.UpdateWorkoutAnalysis(totalSets: totalSets, dumbbellArray: dumbbellArray, elbowArray: elbowArray)

        // Then
       
        let expectedKeys = ["averageUpDownAcceleration", "averageWristLeftRightRotation", "averageWristUpDownRotation", "overallWorkoutUpDownAverage", "overallDumbbellTwistingUpDown", "overallDumbbellTwistingLeftRight", "averageElbowSwing", "averageElbowFlareUpDown", "averageElbowFlareForwardBackward", "overallWorkoutElbowSwing", "overallWorkoutElbowFlareUpDown", "overallWorkoutElbowFlareForwardBackward"]
        XCTAssertEqual(Set(result.keys), Set(expectedKeys), "The result should contain the expected keys.")
        
    }
    
    func testAverageUpDownAcceleration() {
            // Given
            let array = [[1, 2, 11], [4, 5, -11], [7, 8, 210]]
            let append = true
            
            // When
            let result = formCriteria.averageUpDownAcceleration(array: array, append: append)
            
            // Then
           
            XCTAssert(result >= 0 && result <= 1, "The result should be between 0 and 1.")
    }
    
    func testAverageWristLeftRightRotation() {
        // Given
        let array = [[11, 2, 3], [-11, 5, 6], [110, 8, 9]]
        
        // When
        let result = formCriteria.averageWristLeftRightRotation(array: array)
        
        // Then
        // Check that the result is within an expected range:
        XCTAssert(result >= 0 && result <= 1, "The result should be between 0 and 1.")
        
    }
    
    func testOverallWorkoutUpDownAverage() {
        // Given
        let totalSets = 3
        formCriteria.listOfDumbbellAverage = [0.5, 0.6, 0.7]
        
        // When
        let result = formCriteria.overallWorkoutUpDownAverage(totalSets: totalSets)
        
        // Then
        // Check that the result is within an expected range:
        XCTAssert(result >= 0 && result <= 1, "The result should be between 0 and 1.")
        
        let expectedValue = (0.5 + 0.6 + 0.7) / Double(totalSets)
        XCTAssertEqual(result, expectedValue, accuracy: 0.01, "The result should be approximately equal to the expected value.")
    }
    
    func testAverageElbowSwing() {
        // Given
        let array = [[11, 2, 3], [-11, 5, 6], [110, 8, 9]]
        let append = true
        
        // When
        let result = formCriteria.averageElbowSwing(array: array, append: append)
        
        // Then
        // Check that the result is within an expected range:
        XCTAssert(result >= 0 && result <= 1, "The result should be between 0 and 1.")
        
    }
    func testAverageElbowFlareForwardBackward() {
        // Given
        let array = [[11, 12, 13], [14, 15, 16], [17, 18, 19]]
        
        // When
        let result = formCriteria.averageElbowFlareForwardBackward(array: array)
        
        // Then
        // Check that the result is within an expected range:
        XCTAssert(result >= 0 && result <= 1, "The result should be between 0 and 1.")
        
    
    }
    func testOverallWorkoutElbowSwing() {
        // Given
        let totalSets = 3
        formCriteria.listOfElbowSwingAverage = [0.5, 0.6, 0.7]
        
        // When
        let result = formCriteria.overallWorkoutElbowSwing(totalSets: totalSets)
        
        // Then
        // Check that the result is within an expected range:
        XCTAssert(result >= 0 && result <= 1, "The result should be between 0 and 1.")
        
       
        let expectedValue = (0.5 + 0.6 + 0.7) / Double(totalSets)
        XCTAssertEqual(result, expectedValue, accuracy: 0.01, "The result should be approximately equal to the expected value.")
    }
    func testDangerousForm() {
        // Given
        let dumbbellData = [499, 499, 499]
        let elbowData = [299, 299, 299]
        
        // When
        let result = formCriteria.dangerousForm(dumbbellData: dumbbellData, elbowData: elbowData)
        
        // Then
        // Check that the result is false, as none of the data is above the dangerous threshold
        XCTAssertFalse(result, "The result should be false as none of the data is above the dangerous threshold.")
        
        // Test with data above the dangerous threshold
        let dangerousDumbbellData = [500, 500, 500]
        let dangerousElbowData = [300, 300, 300]
        let dangerousResult = formCriteria.dangerousForm(dumbbellData: dangerousDumbbellData, elbowData: dangerousElbowData)
        
        // Check that the result is true, as all of the data is above the dangerous threshold
        XCTAssertTrue(dangerousResult, "The result should be true as all of the data is above the dangerous threshold.")
    }
    func testGiveFeedback() {
        // Given
        let dumbbellArray = [[11, 12, 13], [14, 15, 16], [17, 18, 19]]
        let elbowArray = [[21, 22, 23], [24, 25, 26], [27, 28, 29]]
        
        // When
        let result = formCriteria.giveFeedback(dumbbellArray: dumbbellArray, elbowArray: elbowArray)
        
        // Then
        // Check that the overallAccel and overallElbowSwing strings are formatted correctly
        let averageAcceleration = formCriteria.averageUpDownAcceleration(array: dumbbellArray, append: false)
        let averageElbowSwing = formCriteria.averageElbowSwing(array: elbowArray, append: false)
        let expectedOverallAccel = String(format: "Curl acceleration: %.f%% good", averageAcceleration * 100)
        let expectedOverallElbowSwing = String(format: "Elbow stability: %.f%% good", averageElbowSwing * 100)
        XCTAssertEqual(result.0, expectedOverallAccel, "The overallAccel string should be formatted correctly.")
        XCTAssertEqual(result.1, expectedOverallElbowSwing, "The overallElbowSwing string should be formatted correctly.")
        
        // Check that the dumbbellCustomTextFeedback and elbowCustomTextFeedback strings are correct
        let expectedElbowCustomTextFeedback = averageElbowSwing < 0.7 ? "Keep that elbow steady!" : "Elbow is looking good!!!"
        XCTAssertEqual(result.3, expectedElbowCustomTextFeedback, "The elbowCustomTextFeedback string should be correct.")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
