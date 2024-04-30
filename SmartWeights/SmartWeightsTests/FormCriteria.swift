//
//  FormCriteria.swift
//  SmartWeightsTests
//
//  Created by Tu Ha on 4/26/24.
//

import XCTest

final class FormCriteria: XCTestCase {
    
    var formCriteria = FormCriteria()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
        
        //check for value ranges
        for value in result.values {
            XCTAssert(value >= 0 && value <= 100, "All values should be between 0 and 100.")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
