//
//  APINotificationService.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-08.
//

import Foundation

protocol APINotificationService {
    func askForPermission(completion: @escaping (Bool) -> Void)
}
