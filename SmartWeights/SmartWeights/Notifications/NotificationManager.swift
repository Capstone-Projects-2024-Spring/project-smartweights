//
//  NotificationManager.swift
//  SmartWeights
//
//  Created by Timothy Bui on 4/19/24.
//

import Foundation
import UserNotifications

struct NotificationManager {
    static func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("SUCCESS: Notification permissions granted")
            } else if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    static func scheduleNotification(notificationTimeString: String) {
        guard let date = DateHelper.dateFormatter.date(from: notificationTimeString) else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "SmartWeights"
        content.body = "Notifications are now enabled."
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "SmartWeights", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    static func updateLastWorkoutTime() {
        let now = Date()
        UserDefaults.standard.set(now, forKey: "lastWorkoutStartTime")
    }
    
    static func scheduleWorkoutReminder() {
        guard let lastWorkoutStart = UserDefaults.standard.object(forKey: "lastWorkoutStartTime") as? Date else {
            return
        }

        let calendar = Calendar.current
        if let thirtySecondsLater = calendar.date(byAdding: .second, value: 30, to: lastWorkoutStart) {
            let content = UNMutableNotificationContent()
            content.title = "SmartWeights"
            content.body = "30 seconds have passed since your last activity check. Time to get moving!"
            content.sound = .default

            let triggerDate = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: thirtySecondsLater)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

            let request = UNNotificationRequest(identifier: "workoutReminder", content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("ERROR scheduling 30-second workout reminder: \(error.localizedDescription)")
                }
            }
        }
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

struct DateHelper {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
