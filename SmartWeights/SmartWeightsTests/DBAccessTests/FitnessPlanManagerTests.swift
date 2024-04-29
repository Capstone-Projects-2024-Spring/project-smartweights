
//
//  FitnessPlanManagerTests.swift
//  SmartWeightsTests
//
//  Created by Daniel Eap on 4/27/24.
//

import XCTest
@testable import SmartWeights

final class FitnessPlanManagerTests: XCTestCase {

    var fitnessPlanManager: FitnessPlanDBManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        fitnessPlanManager = FitnessPlanDBManager()
        fitnessPlanManager.fitnessPlan = FitnessPlanModel(recordId: nil, daysPerWeekGoal: 3, dumbbellWeightGoal: 20, setGoal: 4, repGoal: 10, notes: "Sample notes", selectedDate: Date())
    }

    override func tearDownWithError() throws {
        fitnessPlanManager = nil
        try super.tearDownWithError()
    }

    func testCreateFitnessPlan() throws {
        // Given
        let daysPerWeekGoal: Int64 = 3
        let dumbbellWeightGoal: Int64 = 20
        let setGoal: Int64 = 4
        let repGoal: Int64 = 10
        let notes = "Sample notes"
        let selectedDate = Date()

        // When
        fitnessPlanManager.createFitnessPlan(daysPerWeekGoal: daysPerWeekGoal, dumbbellWeightGoal: dumbbellWeightGoal, setGoal: setGoal, repGoal: repGoal, notes: notes, selectedDate: selectedDate)

        // Then
        XCTAssertNotNil(fitnessPlanManager.fitnessPlan)
        XCTAssertEqual(fitnessPlanManager.fitnessPlan?.daysPerWeekGoal, daysPerWeekGoal)
        XCTAssertEqual(fitnessPlanManager.fitnessPlan?.dumbbellWeightGoal, dumbbellWeightGoal)
        XCTAssertEqual(fitnessPlanManager.fitnessPlan?.setGoal, setGoal)
        XCTAssertEqual(fitnessPlanManager.fitnessPlan?.repGoal, repGoal)
        XCTAssertEqual(fitnessPlanManager.fitnessPlan?.notes, notes)
//        XCTAssertEqual(fitnessPlanManager.fitnessPlan?.selectedDate, selectedDate)
    }

}
