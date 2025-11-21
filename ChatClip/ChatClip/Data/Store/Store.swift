//
//  Store.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-16.
//

import Combine
import Foundation

struct RecentNumber: Codable, Hashable {
    let countryCode: String
    let phoneNumber: String
    let date: Date
}

extension RecentNumber {
    static var previews: [RecentNumber] {
        [
            RecentNumber(countryCode: "+1", phoneNumber: "1234567890", date: Date()),
            RecentNumber(countryCode: "+595", phoneNumber: "981123456", date: Date()),
        ]
    }
}

protocol Store {
    var lastCountryCodeUsedPublisher: AnyPublisher<String, Never> { get }
    var remindersPublishers: AnyPublisher<RemindersList, Never> { get }
    var recentNumbersPublisher: AnyPublisher<[RecentNumber], Never> { get }

    func addLastCountryCodeUsed(_ countryCode: String) throws
    func addReminder(_ reminder: Reminder) throws
    func removeReminder(_ reminder: Reminder) throws
    func addRecentNumber(_ recent: RecentNumber) throws
    func removeRecentNumber(_ recent: RecentNumber) throws
    func clearAllRecentNumbers() throws
}
