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
            } else if let error {
                print(error.localizedDescription)
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
    
    static func sendImmediateNotification() {
        let content = UNMutableNotificationContent()
        content.title = "SmartWeights"
        content.subtitle = "Test Notification"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        print("SUCCESS: Notification has been pushed")
    }
    
    static func cancelNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["SmartWeights"])
    }
}

struct DateHelper {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}
