//
//  ChallengesTests.swift
//  SmartWeightsTests
//
//  Created by Timothy Bui on 4/27/24.
//

import Foundation
import SwiftUI
import XCTest
@testable import SmartWeights

class ChallengesTests: XCTestCase {
    var viewModel: ChallengesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ChallengesViewModel()
        
        viewModel.challenges = [
            Challenge(title: "Challenge 1", description: "Desc 1", image: Image(systemName: "star"), achievementIdentifier: "id1", currentProgress: 0, isCompleted: false),
            Challenge(title: "Challenge 2", description: "Desc 2", image: Image(systemName: "star"), achievementIdentifier: "id2", currentProgress: 0, isCompleted: true)
        ]
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testAchievementsFetch() {
        XCTAssertEqual(viewModel.challenges.count, 2)
    }
    
    func testTabFiltering() {
        let challengesInProgress = viewModel.challenges.filter { !$0.isCompleted }
        let challengesCompleted = viewModel.challenges.filter { $0.isCompleted }
        
        XCTAssertEqual(challengesInProgress.count, 1)
        XCTAssertEqual(challengesCompleted.count, 1)
    }
}
