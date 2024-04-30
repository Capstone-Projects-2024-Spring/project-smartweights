//
//  CoreDataManager.swift
//  SmartWeights
//
//  Created by Adam Ra on 4/5/24.
//

import Foundation
import CoreData

/// Manages persistent data storage using Core Data for the SmartWeights application.
class CoreDataManager: ObservableObject {
    /// The shared persistent container from the PersistenceController, configured for CloudKit integration.
    var persistentContainer: NSPersistentCloudKitContainer = PersistenceController.shared.container
    
    /// Initializes the CoreDataManager with the specified persistent container and optional store configurations.
    /// - Parameters:
    ///   - container: The persistent container to use for Core Data operations, typically passed from a shared instance.
    ///   - storeDescriptions: Optional custom configurations for the persistent store.
    init(container: NSPersistentCloudKitContainer, storeDescriptions: [NSPersistentStoreDescription]? = nil) {
        self.persistentContainer = container
        if let storeDescriptions = storeDescriptions {
            persistentContainer.persistentStoreDescriptions = storeDescriptions
        } else {
            // Default store description with history tracking and automatic migration.
            let description = NSPersistentStoreDescription()
            description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
            description.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
            description.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
            persistentContainer.persistentStoreDescriptions = [description]
        }

        // Load the persistent stores and handle potential errors.
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if error != nil {
//                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    /// Creates and saves a new WorkoutSession entity with specified parameters.
    /// - Parameters:
    ///   - dateTime: The date and time when the workout session occurred.
    ///   - workoutNum: A unique identifier for the workout session.
    ///   - reps: Number of repetitions in the workout.
    ///   - weight: Weight used in the workout.
    ///   - overallCurlAcceleration: Measure of acceleration during curl exercises.
    ///   - overallElbowFlareLR: Left-right elbow flare measurement.
    ///   - overallElbowFlareUD: Up-down elbow flare measurement.
    ///   - overallElbowSwing: Measurement of elbow swing during the workout.
    ///   - overallWristStabilityLR: Left-right wrist stability measurement.
    ///   - overallWristStabilityUD: Up-down wrist stability measurement.
    /// - Returns: The newly created WorkoutSession or nil if saving fails.
    func createWorkoutSession(dateTime: Date, workoutNum: Int, reps: Int, weight: Double, overallCurlAcceleration: Double, overallElbowFlareLR: Double, overallElbowFlareUD: Double, overallElbowSwing: Double, overallWristStabilityLR: Double, overallWristStabilityUD: Double) -> WorkoutSession? {
            let context = persistentContainer.viewContext
            let workoutSession = WorkoutSession(context: context)

            // Format and set the date for the session.
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: dateTime)
            print(dateString)
        
            // Set other properties.
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
        
            // Attempt to save the new session to the persistent store.
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

    /// Creates and persists a new ExerciseSet entity associated with a given WorkoutSession.
    /// - Parameters:
    ///   - workoutSession: The WorkoutSession to which the ExerciseSet will be linked.
    ///   - setNum: The sequence number of the set in the workout.
    ///   - avgCurlAcceleration: Average acceleration during the curl exercises in this set.
    ///   - avgElbowFlareLR: Average left-right elbow flare during the exercises.
    ///   - avgElbowFlareUD: Average up-down elbow flare during the exercises.
    ///   - avgElbowSwing: Average elbow swing during the exercises.
    ///   - avgWristStabilityLR: Average left-right wrist stability during the exercises.
    ///   - avgWristStabilityUD: Average up-down wrist stability during the exercises.
    /// - Returns: The newly created ExerciseSet or nil if an error occurs during saving.
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

    /// Fetches all WorkoutSession entities from the persistent store.
    /// - Returns: An array of WorkoutSession entities, possibly empty if no records are found or an error occurs.
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
    
    /// Fetches WorkoutSession entities on a specific date from the persistent store.
    /// - Parameter date: The date to filter the workout sessions.
    /// - Returns: An array of dictionary representations of workout sessions, possibly empty if an error occurs.
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
        fetchRequest.propertiesToFetch = ["weight","reps","workoutNum", "overallCurlAcceleration", "overallElbowFlareLeftRight", "overallElbowFlareUpDown", "overallElbowSwing", "overallWristStabilityLeftRight", "overallWristStabilityUpDown"]
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest) as! [[String: Any]]
            print("*****************************************Fetched workout sessions on date \(dateString): \(results)")
            return results
        } catch {
            print("Failed to fetch workout sessions on date \(dateString): \(error)")
            return []
        }
    }
    
    /// Retrieves the next sequential workout number to be used for a new WorkoutSession, defaulting to 1 if no sessions exist.
    /// - Returns: An integer representing the next workout number.
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
    
    /// Fetches ExerciseSet entities associated with a specific WorkoutSession.
    /// - Parameter workoutSession: The WorkoutSession to filter the ExerciseSets by.
    /// - Returns: An array of ExerciseSet entities, possibly empty if no sets are found or an error occurs.
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
    
    /// Fetches all ExerciseSet entities from the persistent store.
    /// - Returns: An array of ExerciseSet entities, possibly empty if no records are found or an error occurs.
    func fetchAllExerciseSets() -> [ExerciseSet] {
        let fetchRequest: NSFetchRequest<ExerciseSet> = ExerciseSet.fetchRequest()

        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch sets: \(error)")
            return []
        }
    }

    /// Fetches ExerciseSet entities based on a specific workout number.
    /// - Parameter workoutNum: The workout number to filter the ExerciseSets by.
    /// - Returns: An array of dictionary representations of ExerciseSets, possibly empty if an error occurs.
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
    
    /// Updates properties of a WorkoutSession entity.
    /// - Parameters:
    ///   - session: The WorkoutSession to update.
    ///   - dateTime: Optional new date and time for the session.
    ///   - overallCurlAcceleration: Optional new curl acceleration measurement.
    ///   - overallElbowFlareLR: Optional new left-right elbow flare measurement.
    ///   - overallElbowFlareUD: Optional new up-down elbow flare measurement.
    ///   - overallElbowSwing: Optional new elbow swing measurement.
    ///   - overallWristStabilityLR: Optional new left-right wrist stability measurement.
    ///   - overallWristStabilityUD: Optional new up-down wrist stability measurement.
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
    
    /// Updates properties of an ExerciseSet entity.
    /// - Parameters:
    ///   - exerciseSet: The ExerciseSet to update.
    ///   - setNum: Optional new set number.
    ///   - avgCurlAcceleration: Optional new average curl acceleration.
    ///   - avgElbowFlareLR: Optional new average left-right elbow flare.
    ///   - avgElbowFlareUD: Optional new average up-down elbow flare.
    ///   - avgElbowSwing: Optional new average elbow swing.
    ///   - avgWristStabilityLR: Optional new average left-right wrist stability.
    ///   - avgWristStabilityUD: Optional new average up-down wrist stability.
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
