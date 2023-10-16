//
//  PreviewsStore.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-16.
//

import Foundation
import Combine

final class PreviewsStore: Store {
    
    @Published private var reminders = Reminder.previews
    @Published private var lastCountryCodeUsed = ""
    
    var remindersPublishers: AnyPublisher<RemindersList, Never> {
        $reminders
            .eraseToAnyPublisher()
    }
    
    func addReminder(_ reminder: Reminder) throws {
        reminders.append(reminder)
    }
    
    func removeReminder(_ reminder: Reminder) throws {
        reminders.removeAll(where: { $0.id == reminder.id })
    }
    
    var lastCountryCodeUsedPublisher: AnyPublisher<String, Never> {
        $lastCountryCodeUsed
            .eraseToAnyPublisher()
    }
    
    func addLastCountryCodeUsed(_ countryCode: String) throws {
        lastCountryCodeUsed = countryCode
    }
}
