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

    func createSet(workoutSession: WorkoutSession, setNum: Int, avgCurlAcceleration: Double, avgElbowFlareLR: Double, avgElbowFlareUD: Double, avgElbowSwing: Double, avgWristStabilityLR: Double, avgWristStabilityUD: Double) -> Set? {
            let context = persistentContainer.viewContext
            let set = Set(context: context)
            
            set.workoutSession = workoutSession
            set.setNum = Int64(setNum)
            set.avgCurlAcceleration = avgCurlAcceleration
            set.avgElbowFlareLeftRight = avgElbowFlareLR
            set.avgElbowFlareUpDown = avgElbowFlareUD
            set.avgElbowSwing = avgElbowSwing
            set.avgWristStabilityLeftRight = avgWristStabilityLR
            set.avgWristStabilityUpDown = avgWristStabilityUD
            
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
}
