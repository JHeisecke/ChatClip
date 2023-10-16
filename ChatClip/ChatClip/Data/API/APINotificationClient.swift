//
//  APINotification.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-08.
//

import UserNotifications
import Foundation

struct APINotificationClient: APINotificationService {
    let center = UNUserNotificationCenter.current()
    
    func askForPermission(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.badge, .alert, .sound]) { granted, error in
            if let error {
                print("Unable to grant permissions \(error)")
            }
            completion(granted)
        }
    }
    
    func scheduleAlert(_ reminder: Reminder, completion: @escaping (Bool) -> Void) {
        guard let dateToRemind = reminder.time else {
            completion(true)
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "Text to +\(reminder.number)"
        if let title = reminder.title {
            content.body = title
        }
        content.sound = .default
        
        
        let trigger  = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute, .second],
                from: dateToRemind
            ),
            repeats: false)
        let request = UNNotificationRequest(identifier: reminder.id, content: content, trigger: trigger)
        center.add(request) { error in
            guard let error else {
                completion(true)
                return
            }
            completion(false)
            print("Something went wrong \(error)")
        }
    }
    
    func removeNotification(_ reminder: Reminder) {
        if let date = reminder.time, date > Date.now {
            center.removeDeliveredNotifications(withIdentifiers: [reminder.id])
        } else {
            center.removePendingNotificationRequests(withIdentifiers: [reminder.id])
        }
    }
}
