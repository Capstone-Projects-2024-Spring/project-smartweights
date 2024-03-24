//
//  StartWorkoutIntentHandler.swift
//  SmartWeightsExtention
//
//  Created by Daniel Eap on 3/24/24.
//

import Foundation
import Intents

class StartWorkoutIntentHandler: NSObject, StartWorkoutIntentHandling {
    func handle(intent: StartWorkoutIntent, completion: @escaping (StartWorkoutIntentResponse) -> Void) {
           // Start the workout timer or perform any other relevant actions
           startWorkout()
           var vm = WorkoutViewModel()
        vm.startTimer()
        completion(StartWorkoutIntentResponse.success("success"))
           
           
       }
       
       // Example method to start the workout
       private func startWorkout() {
           // Implement your logic to start the workout timer or perform any other actions here
           print("Workout started")
       }
    
   
}

