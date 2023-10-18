//
//  APINotificationService.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-08.
//

import Foundation

protocol APINotificationService {
    func askForPermission(completion: @escaping (Bool) -> Void)
    func scheduleAlert(_ reminder: Reminder, completion: @escaping (Bool) -> Void)
    func removeNotification(_ reminder: Reminder)
}
