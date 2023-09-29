//
//  Reminder.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation

typealias RemindersList = [Reminder]

struct Reminder {
    var id: String
    var title: String?
    var time: Date?
    var number: String
    var message: String?
}
