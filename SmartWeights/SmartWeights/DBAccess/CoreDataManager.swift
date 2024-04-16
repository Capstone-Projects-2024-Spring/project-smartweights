//
//  CoreDataManager.swift
//  SmartWeights
//
//  Created by Adam Ra on 4/5/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "SmartWeights")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error{
            fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func createWorkoutSession(dateTime: Date, workoutNum: Int) -> WorkoutSession? {
        let context = persistentContainer.viewContext
        let workoutSession = WorkoutSession(context: context)
        workoutSession.dateTime = dateTime
        workoutSession.workoutNum = Int64(workoutNum)
        
        do {
            try context.save()
            return workoutSession
        } catch {
            print("Failed to create workout session: \(error)")
            return nil
        }
    }

    func createSet(workoutSession: WorkoutSession, setNum: Int, feedback: String, elbowStability: Double, wristStability: Double, velocity: Double) -> Set? {
        let context = persistentContainer.viewContext
        let set = Set(context: context)
        set.workoutSession = workoutSession
        set.setNum = Int64(setNum)
        set.feedback = feedback
        set.elbowStabilityLeftRight = elbowStability
        set.elbowStabilityUpDown = elbowStability
        set.wristStabilityLeftRight = wristStability
        set.wristStabilityUpDown = wristStability
        set.velocity = velocity
        
        do {
            try context.save()
            return set
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


}
