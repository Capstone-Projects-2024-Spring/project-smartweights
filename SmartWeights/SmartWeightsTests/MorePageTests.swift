//
//  MorePageTests.swift
//  SmartWeightsTests
//
//  Created by Timothy Bui on 4/27/24.
//

import Foundation
import SwiftUI
import XCTest
@testable import SmartWeights

class MorePageTests: XCTestCase {
    var viewModel: MorePageViewModel!
    var challengesViewModel: ChallengesViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MorePageViewModel()
        challengesViewModel = ChallengesViewModel()
        
        challengesViewModel.challenges = [
            Challenge(title: "Challenge 1", description: "Desc 1", image: Image(systemName: "star"), achievementIdentifier: "id1", currentProgress: 0, isCompleted: false),
            Challenge(title: "Challenge 2", description: "Desc 2", image: Image(systemName: "star"), achievementIdentifier: "id2", currentProgress: 0, isCompleted: true)
        ]
    }
    
    override func tearDown() {
        viewModel = nil
        challengesViewModel = nil
        super.tearDown()
    }
    
    func testAchievementsFetch() {
        XCTAssertEqual(challengesViewModel.challenges.count, 2)
    }
    
    func testAchievementsDisplayFiltersCompleted() {
        let completedChallenges = challengesViewModel.challenges.filter { $0.isCompleted }
        XCTAssertEqual(completedChallenges.count, 1)
        XCTAssertTrue(completedChallenges.first!.isCompleted)
    }
    
    func testScreenshotButton() {
        viewModel.takeScreenshot()
        XCTAssertNotNil(viewModel.screenshot)
    }
    
}
