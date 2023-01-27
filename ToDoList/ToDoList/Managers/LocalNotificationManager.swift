//
//  LocalNotificationManager.swift
//  ToDoList
//
//  Created by Taimur Mushtaq on 27/01/2023.
//

import Foundation
import UserNotifications

enum LocalNotificationManager {
    static func configure() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("User gave permissions for local notifications")
            }
        }
    }
    
    static func addNotification(withTitle title:String, identifier:String, onDate date: Date) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "\(AppStrings.notificationContent.body.rawValue) \(date.convertToString(withFormat: DateFormats.taskTimerFormat.rawValue))"
        content.categoryIdentifier = identifier
        content.sound = .default
        
        let fireDate = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: fireDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                print("Error = \(error?.localizedDescription ?? "error local notification")")
            }
        }
    }
    
    static func cancelNotification(identifiers:[String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    static func cancelAllNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
