//
//  CoreDataManager.swift
//  SmartWeights
//
//  Created by Adam Ra on 4/5/24.
//

import Foundation
import CoreData

class CoreDataManager: ObservableObject {
    
    let persistentContainer: NSPersistentCloudKitContainer
    
    init() {
        // Use the shared managed object model defined in PersistenceController
        persistentContainer = NSPersistentCloudKitContainer(name: "SmartWeights", managedObjectModel: PersistenceController.sharedManagedObjectModel)
            
            let description = NSPersistentStoreDescription()
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
            description.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)

            // Add this description to your persistent container
            persistentContainer.persistentStoreDescriptions = [description]

            persistentContainer.loadPersistentStores { (storeDescription, error) in
                if let error = error {
                    fatalError("Core Data Store failed \(error.localizedDescription)")
                }
            }
    }
    
    func createWorkoutSession(dateTime: Date, workoutNum: Int, overallCurlAcceleration: Double, overallElbowFlareLR: Double, overallElbowFlareUD: Double, overallElbowSwing: Double, overallWristStabilityLR: Double, overallWristStabilityUD: Double) -> WorkoutSession? {
            let context = persistentContainer.viewContext
            let workoutSession = WorkoutSession(context: context)
            
            workoutSession.dateTime = dateTime
            workoutSession.workoutNum = Int64(workoutNum)
            workoutSession.overallCurlAcceleration = overallCurlAcceleration
            workoutSession.overallElbowFlareLeftRight = overallElbowFlareLR
            workoutSession.overallElbowFlareUpDown = overallElbowFlareUD
            workoutSession.overallElbowSwing = overallElbowSwing
            workoutSession.overallWristStabilityLeftRight = overallWristStabilityLR
            workoutSession.overallWristStabilityUpDown = overallWristStabilityUD
            
            do {
                try context.save()
                return workoutSession
            } catch {
                print("Failed to create workout session: \(error)")
                return nil
            }
        }

    func createExerciseSet(workoutSession: WorkoutSession, setNum: Int, avgCurlAcceleration: Double, avgElbowFlareLR: Double, avgElbowFlareUD: Double, avgElbowSwing: Double, avgWristStabilityLR: Double, avgWristStabilityUD: Double) -> ExerciseSet? {
            let context = persistentContainer.viewContext
            let exerciseSet = ExerciseSet(context: context)
            
            exerciseSet.workoutSession = workoutSession
            exerciseSet.setNum = Int64(setNum)
            exerciseSet.avgCurlAcceleration = avgCurlAcceleration
            exerciseSet.avgElbowFlareLeftRight = avgElbowFlareLR
            exerciseSet.avgElbowFlareUpDown = avgElbowFlareUD
            exerciseSet.avgElbowSwing = avgElbowSwing
            exerciseSet.avgWristStabilityLeftRight = avgWristStabilityLR
            exerciseSet.avgWristStabilityUpDown = avgWristStabilityUD
            
            do {
                try context.save()
                return exerciseSet
            } catch {
                print("Failed to create set: \(error)")
                return nil
            }
        }

    func fetchWorkoutSessions() -> [WorkoutSession] {
        let fetchRequest: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch workout sessions: \(error)")
            return []
        }
    }
    
    func getNextWorkoutNumber() -> Int {
        let fetchRequest: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "workoutNum", ascending: false)]
        fetchRequest.fetchLimit = 1
        
        do {
            let lastSession = try persistentContainer.viewContext.fetch(fetchRequest).first
            return Int((lastSession?.workoutNum ?? 0) + 1)
        } catch {
            print("Failed to fetch last workout number: \(error)")
            return 1 // If fetch fails, start with 1
        }
    }
    
    func fetchExerciseSets(for workoutSession: WorkoutSession) -> [ExerciseSet] {
        let fetchRequest: NSFetchRequest<ExerciseSet> = ExerciseSet.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "workoutSession == %@", workoutSession)

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch sets for workout session: \(error)")
            return []
        }
    }
    
    func fetchAllExerciseSets() -> [ExerciseSet] {
        let fetchRequest: NSFetchRequest<ExerciseSet> = ExerciseSet.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch sets: \(error)")
            return []
        }
    }
    
    func updateWorkoutSession(_ session: WorkoutSession, dateTime: Date? = nil, overallCurlAcceleration: Double? = nil, overallElbowFlareLR: Double? = nil, overallElbowFlareUD: Double? = nil, overallElbowSwing: Double? = nil, overallWristStabilityLR: Double? = nil, overallWristStabilityUD: Double? = nil) {
        let context = persistentContainer.viewContext
        
        // Update the properties of the session if new values are provided
        if let dateTime = dateTime {
            session.dateTime = dateTime
        }
        if let acc = overallCurlAcceleration {
            session.overallCurlAcceleration = acc
        }
        if let flareLR = overallElbowFlareLR {
            session.overallElbowFlareLeftRight = flareLR
        }
        if let flareUD = overallElbowFlareUD {
            session.overallElbowFlareUpDown = flareUD
        }
        if let swing = overallElbowSwing {
            session.overallElbowSwing = swing
        }
        if let wristLR = overallWristStabilityLR {
            session.overallWristStabilityLeftRight = wristLR
        }
        if let wristUD = overallWristStabilityUD {
            session.overallWristStabilityUpDown = wristUD
        }
        
        // Attempt to save the updated session
        do {
            try context.save()
        } catch {
            print("Failed to update workout session: \(error)")
        }
    }

}
