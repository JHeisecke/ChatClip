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
}
