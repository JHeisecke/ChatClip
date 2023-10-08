//
//  AppDAta.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation

struct AppData {
    @Storage(key: UserDefaultsKeys.lastCountryCodeUsed, defaultValue: nil)
    static var lastCountryCodeUsed: String?
    @Storage(key: UserDefaultsKeys.reminders, defaultValue: Reminder.previews)
    static var reminders: RemindersList
}
