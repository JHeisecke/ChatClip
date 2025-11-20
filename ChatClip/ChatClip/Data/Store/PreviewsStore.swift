//
//  PreviewsStore.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-16.
//

import Combine
import Foundation
import SwiftUI

final class PreviewsStore: Store {

    @Published private var reminders = Reminder.previews
    @Published private var lastCountryCodeUsed = ""
    @Published private var recentNumbers: [RecentNumber] = RecentNumber.previews

    var lastCountryCodeUsedPublisher: AnyPublisher<String, Never> {
        $lastCountryCodeUsed.eraseToAnyPublisher()
    }

    var remindersPublishers: AnyPublisher<RemindersList, Never> {
        $reminders.eraseToAnyPublisher()
    }

    var recentNumbersPublisher: AnyPublisher<[RecentNumber], Never> {
        $recentNumbers.eraseToAnyPublisher()
    }

    func addLastCountryCodeUsed(_ countryCode: String) throws {
        lastCountryCodeUsed = countryCode
    }

    func addReminder(_ reminder: Reminder) throws {
        reminders.append(reminder)
    }

    func removeReminder(_ reminder: Reminder) throws {
        reminders.removeAll { $0.id == reminder.id }
    }

    func addRecentNumber(_ recent: RecentNumber) throws {
        recentNumbers.insert(recent, at: 0)
    }
}
