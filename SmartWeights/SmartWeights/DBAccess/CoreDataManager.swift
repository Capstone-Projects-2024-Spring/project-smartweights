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
    
    func createWorkout(userID: Int32, workoutID: Int32, speed: Float, velocity: Float, angle: Float, dateTime: Date, xCoord: Float, yCoord: Float, zCoord: Float) -> Workout? {
        let context = persistentContainer.viewContext
        let workout = NSEntityDescription.insertNewObject(forEntityName: "Workout", into: context) as! Workout

        workout.user_id = userID
        workout.workout_id = workoutID
        workout.speed = speed
        workout.velocity = velocity
        workout.angle = angle
        workout.dateTime = dateTime
        workout.x_coord = xCoord
        workout.y_coord = yCoord
        workout.z_coord = zCoord
        
        do {
            try context.save()
            return workout
        } catch {
            print("Failed to save workout: \(error)")
            return nil
        }
    }
    
    func fetchWorkouts() -> [Workout] {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch workouts: \(error)")
            return []
        }
    }

    func updateWorkout(workout: Workout) {
        let context = persistentContainer.viewContext
        
        // Changes to the `Workout` object would be made before this function is called
                
        do {
            try context.save()
        } catch {
            print("Failed to update workout: \(error)")
        }
    }
    
    func deleteWorkout(workout: Workout) {
        let context = persistentContainer.viewContext
        context.delete(workout)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete workout: \(error)")
        }
    }
    
    func createForm(workout: Workout, formID: Int16, score: Int16, feedback: String, dateTimeForm: Date) -> Form? {
        let context = persistentContainer.viewContext
        let form = NSEntityDescription.insertNewObject(forEntityName: "Form", into: context) as! Form

        form.form_id = formID
        form.score = score
        form.feedback = feedback
        form.dateTimeForm = dateTimeForm
        
        do {
            try context.save()
            return form
        } catch {
            print("Failed to save form: \(error)")
            return nil
        }
    }
    
    func fetchForms(for workout: Workout) -> [Form] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Form> = Form.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "workout == %@", workout)
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch forms: \(error)")
            return []
        }
    }
    
    func updateForm(form: Form) {
        let context = persistentContainer.viewContext
        
        // Changes to the `form` object would be made before this function is called
        
        do {
            try context.save()
        } catch {
            print("Failed to update form: \(error)")
        }
    }
    
    func deleteForm(form: Form) {
        let context = persistentContainer.viewContext
        context.delete(form)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete form: \(error)")
        }
    }
}
