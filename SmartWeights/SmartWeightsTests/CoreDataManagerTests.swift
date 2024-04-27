//
//  CoreDataManagerTests.swift
//  SmartWeightsTests
//
//  Created by Adam Ra on 4/27/24.
//

import Foundation
import XCTest
import CoreData
@testable import SmartWeights

class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let container = NSPersistentCloudKitContainer(name: "SmartWeights", managedObjectModel: PersistenceController.sharedManagedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        coreDataManager = CoreDataManager(container: container, storeDescriptions: [description])
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
//                fatalError("Failed to load stores: \(error.localizedDescription)")
            }
        }
    }

    override func tearDownWithError() throws {
        // Tear down and clean up after each test
        let persistentStoreCoordinator = coreDataManager.persistentContainer.persistentStoreCoordinator
        for store in persistentStoreCoordinator.persistentStores {
            do {
                try persistentStoreCoordinator.remove(store)
            } catch {
                XCTFail("Error removing persistent store: \(error)")
            }
        }
        coreDataManager = nil
        try super.tearDownWithError()
    }

    func testCreateWorkoutSession() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        XCTAssertNotNil(workoutSession, "Workout session should not be nil")
    }

    // Integration test between createWorkoutSession & fetchWorkoutSessions
    func testCreateAndFetchWorkoutSessions() {
        let _ = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let workoutSessions = coreDataManager.fetchWorkoutSessions()
        XCTAssert(workoutSessions.count > 0, "Fetched workout sessions should include the session we just created")
    }

    func testFetchWorkoutSessions() {
        let _ = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let workoutSessions = coreDataManager.fetchWorkoutSessions()
        XCTAssert(workoutSessions.count > 0, "Fetched workout sessions should include the session we just created")
    }

    func testFetchWorkoutSessionsOnDate() {
        let _ = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let workoutSessions = coreDataManager.fetchWorkoutSessions(on: Date())
        XCTAssert(workoutSessions.count > 0, "Fetched workout sessions for today should include the session we just created")
    }

    func testGetNextWorkoutNumber() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let nextWorkoutNumber = coreDataManager.getNextWorkoutNumber()
        XCTAssert(nextWorkoutNumber > workoutSession!.workoutNum, "Next workout number should be greater than the workout number of the session we just created")
    }

    func testFetchExerciseSets() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let _ = coreDataManager.createExerciseSet(workoutSession: workoutSession!, setNum: 1, avgCurlAcceleration: 1.0, avgElbowFlareLR: 1.0, avgElbowFlareUD: 1.0, avgElbowSwing: 1.0, avgWristStabilityLR: 1.0, avgWristStabilityUD: 1.0)
        let exerciseSets = coreDataManager.fetchExerciseSets(for: workoutSession!)
        XCTAssert(exerciseSets.count > 0, "Fetched exercise sets for the session should include the set we just created")
    }

    func testUpdateWorkoutSession() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        coreDataManager.updateWorkoutSession(workoutSession!, dateTime: Date(), overallCurlAcceleration: 2.0, overallElbowFlareLR: 2.0, overallElbowFlareUD: 2.0, overallElbowSwing: 2.0, overallWristStabilityLR: 2.0, overallWristStabilityUD: 2.0)
        XCTAssertEqual(workoutSession?.overallCurlAcceleration, 2.0, "Updated workout session should have the new overallCurlAcceleration value")
    }

    func testUpdateExerciseSet() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let exerciseSet = coreDataManager.createExerciseSet(workoutSession: workoutSession!, setNum: 1, avgCurlAcceleration: 1.0, avgElbowFlareLR: 1.0, avgElbowFlareUD: 1.0, avgElbowSwing: 1.0, avgWristStabilityLR: 1.0, avgWristStabilityUD: 1.0)
        coreDataManager.updateExerciseSet(exerciseSet!, setNum: 2, avgCurlAcceleration: 2.0, avgElbowFlareLR: 2.0, avgElbowFlareUD: 2.0, avgElbowSwing: 2.0, avgWristStabilityLR: 2.0, avgWristStabilityUD: 2.0)
        XCTAssertEqual(exerciseSet?.avgCurlAcceleration, 2.0, "Updated exercise set should have the new avgCurlAcceleration value")
    }

    func testFetchAllExerciseSets() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let _ = coreDataManager.createExerciseSet(workoutSession: workoutSession!, setNum: 1, avgCurlAcceleration: 1.0, avgElbowFlareLR: 1.0, avgElbowFlareUD: 1.0, avgElbowSwing: 1.0, avgWristStabilityLR: 1.0, avgWristStabilityUD: 1.0)
        let _ = coreDataManager.createExerciseSet(workoutSession: workoutSession!, setNum: 2, avgCurlAcceleration: 1.0, avgElbowFlareLR: 1.0, avgElbowFlareUD: 1.0, avgElbowSwing: 1.0, avgWristStabilityLR: 1.0, avgWristStabilityUD: 1.0)
        let exerciseSets = coreDataManager.fetchAllExerciseSets()
        XCTAssert(exerciseSets.count >= 2, "Fetched exercise sets should include the sets we just created")
    }

    func testFetchExerciseSetsForWorkoutNum() {
        let workoutSession = coreDataManager.createWorkoutSession(dateTime: Date(), workoutNum: 1, reps: 10, weight: 50.0, overallCurlAcceleration: 1.0, overallElbowFlareLR: 1.0, overallElbowFlareUD: 1.0, overallElbowSwing: 1.0, overallWristStabilityLR: 1.0, overallWristStabilityUD: 1.0)
        let _ = coreDataManager.createExerciseSet(workoutSession: workoutSession!, setNum: 1, avgCurlAcceleration: 1.0, avgElbowFlareLR: 1.0, avgElbowFlareUD: 1.0, avgElbowSwing: 1.0, avgWristStabilityLR: 1.0, avgWristStabilityUD: 1.0)
        let exerciseSets = coreDataManager.fetchExerciseSets(for: workoutSession!.workoutNum)
        XCTAssert(exerciseSets.count > 0, "Fetched exercise sets for the workout number should include the set we just created")
    }
}
