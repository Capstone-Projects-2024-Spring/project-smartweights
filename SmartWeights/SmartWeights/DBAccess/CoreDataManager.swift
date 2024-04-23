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
    
    func createWorkoutSession(dateTime: Date, workoutNum: Int, reps: Int, weight: Double, overallCurlAcceleration: Double, overallElbowFlareLR: Double, overallElbowFlareUD: Double, overallElbowSwing: Double, overallWristStabilityLR: Double, overallWristStabilityUD: Double) -> WorkoutSession? {
            let context = persistentContainer.viewContext
            let workoutSession = WorkoutSession(context: context)

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: dateTime)
            print(dateString)
            workoutSession.reps = Int64(reps)
            workoutSession.weight = weight
            workoutSession.dateTime = dateFormatter.date(from: dateString)
            workoutSession.workoutNum = Int64(workoutNum)
            workoutSession.overallCurlAcceleration = overallCurlAcceleration
            workoutSession.overallElbowFlareLeftRight = overallElbowFlareLR
            workoutSession.overallElbowFlareUpDown = overallElbowFlareUD
            workoutSession.overallElbowSwing = overallElbowSwing
            workoutSession.overallWristStabilityLeftRight = overallWristStabilityLR
            workoutSession.overallWristStabilityUpDown = overallWristStabilityUD
            
            do {
                try context.save()
                print("--------------------Im saving the workout session-------------------",workoutSession.dateTime!)
                print(workoutSession)
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
        print("-----------DATA CORE MANAGER FETCH WORKOUT SESSIONS ------------WITHOUT DATE-----------")
        let fetchRequest: NSFetchRequest<WorkoutSession> = WorkoutSession.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch workout sessions: \(error)")
            return []
        }
    }
    
    func fetchWorkoutSessions(on date: Date) -> [[String: Any]] {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = WorkoutSession.fetchRequest()
        
        // Set up the date formatter to ignore time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let dateString = dateFormatter.string(from: date)

        // Set the predicate to match dates
        fetchRequest.predicate = NSPredicate(format: "dateTime >= %@ AND dateTime < %@", argumentArray: [dateFormatter.date(from: dateString)!, Calendar.current.date(byAdding: .day, value: 1, to: dateFormatter.date(from: dateString)!)!])

        // Specify that the fetch request should return dictionaries
        fetchRequest.resultType = .dictionaryResultType

        // Specify the properties to fetch
        fetchRequest.propertiesToFetch = ["workoutNum", "overallCurlAcceleration", "overallElbowFlareLeftRight", "overallElbowFlareUpDown", "overallElbowSwing", "overallWristStabilityLeftRight", "overallWristStabilityUpDown"]
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest) as! [[String: Any]]
        } catch {
            print("Failed to fetch workout sessions on date \(dateString): \(error)")
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

    func fetchExerciseSets(for workoutNum: Int64) -> [[String: Any]] {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ExerciseSet.fetchRequest()
    let predicateWorkoutSession = NSPredicate(format: "workoutSession.workoutNum == %d", workoutNum)

    fetchRequest.predicate = predicateWorkoutSession
    fetchRequest.resultType = .dictionaryResultType

    fetchRequest.propertiesToFetch = ["setNum", "avgCurlAcceleration", "avgElbowFlareLeftRight", "avgElbowFlareUpDown", "avgElbowSwing", "avgWristStabilityLeftRight", "avgWristStabilityUpDown"]
    do {
        let result = try persistentContainer.viewContext.fetch(fetchRequest)
        return result as? [[String: Any]] ?? [[:]]
    } catch {
        print("Failed to fetch exercise sets for workout number \(workoutNum): \(error)")
        return [[:]]
    }
}
    
    func updateWorkoutSession(_ session: WorkoutSession, dateTime: Date? = nil, overallCurlAcceleration: Double? = nil, overallElbowFlareLR: Double? = nil, overallElbowFlareUD: Double? = nil, overallElbowSwing: Double? = nil, overallWristStabilityLR: Double? = nil, overallWristStabilityUD: Double? = nil) {
        let context = persistentContainer.viewContext
        
        // Update the properties of the session if new values are provided
        if let dateTime = dateTime {
            print("-----------DATA CORE MANAGER DATE TIME -----------------------",dateTime)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: dateTime)
            //session.dateTime = dateTime
            session.dateTime = dateFormatter.date(from: dateString)
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
    
    func updateExerciseSet(_ exerciseSet: ExerciseSet, setNum: Int? = nil, avgCurlAcceleration: Double? = nil, avgElbowFlareLR: Double? = nil, avgElbowFlareUD: Double? = nil, avgElbowSwing: Double? = nil, avgWristStabilityLR: Double? = nil, avgWristStabilityUD: Double? = nil) {
        let context = persistentContainer.viewContext

        // Update the properties of the exercise set if new values are provided
        if let setNum = setNum {
            exerciseSet.setNum = Int64(setNum)
        }
        if let acc = avgCurlAcceleration {
            exerciseSet.avgCurlAcceleration = acc
        }
        if let flareLR = avgElbowFlareLR {
            exerciseSet.avgElbowFlareLeftRight = flareLR
        }
        if let flareUD = avgElbowFlareUD {
            exerciseSet.avgElbowFlareUpDown = flareUD
        }
        if let swing = avgElbowSwing {
            exerciseSet.avgElbowSwing = swing
        }
        if let wristLR = avgWristStabilityLR {
            exerciseSet.avgWristStabilityLeftRight = wristLR
        }
        if let wristUD = avgWristStabilityUD {
            exerciseSet.avgWristStabilityUpDown = wristUD
        }
        
        // Attempt to save the updated exercise set
        do {
            try context.save()
        } catch {
            print("Failed to update exercise set: \(error)")
        }
    }
}
