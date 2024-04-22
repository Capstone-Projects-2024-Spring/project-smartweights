//
//  NotificationManager.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/19/24.
//

import SwiftUI
import Foundation
import UserNotifications

struct NotificationManager {
    @AppStorage("notificationFrequency") static var notificationFrequency: String = "Daily"

    static func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("SUCCESS: Notification permissions granted")
            } else if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    static func updateLastWorkoutTime() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: "lastWorkoutStartTime")
    }
    
    static func scheduleWorkoutReminder() {
        guard let lastWorkoutStart = UserDefaults.standard.object(forKey: "lastWorkoutStartTime") as? Date else {
            return
        }
        
        var components = DateComponents()
        components.hour = Calendar.current.component(.hour, from: lastWorkoutStart)
        components.minute = Calendar.current.component(.minute, from: lastWorkoutStart)

        switch notificationFrequency {
        case "Daily":
            components.day = Calendar.current.component(.day, from: lastWorkoutStart) + 1
        case "Bidaily":
            components.day = Calendar.current.component(.day, from: lastWorkoutStart) + 2
        case "Weekly":
            components.day = Calendar.current.component(.day, from: lastWorkoutStart) + 7
        default:
            break
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: createNotificationContent(), trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ERROR scheduling workout reminder: \(error.localizedDescription)")
            }
        }
    }

    static func createNotificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "SmartWeights"
        content.body = "Time for your workout as per your \(notificationFrequency.lowercased()) schedule!"
        content.sound = .default
        return content
    }

    
    static func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "SmartWeights"
        content.subtitle = "Test Notification"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS: Notification has been pushed")
            }
        }
    }
    
    static func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("SUCCESS: Notifications cancelled")
    }
}
