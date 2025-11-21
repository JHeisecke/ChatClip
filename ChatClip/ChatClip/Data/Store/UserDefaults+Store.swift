//
//  UserDefaults+Store.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-16.
//

import Combine
import Foundation

extension UserDefaults: Store {

    /// We access the locations saved in the UserDefaults singleton by using the key defined previously
    /// We get rid of nil values using .compactMap
    /// We decode the value saved in UserDefaults to the type [Location]
    /// In case of error we publish an empty array
    var remindersPublishers: AnyPublisher<RemindersList, Never> {
        publisher(for: \.reminders)
            .compactMap { $0 }
            .decode(
                type: RemindersList.self,
                decoder: JSONDecoder()
            )
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    var lastCountryCodeUsedPublisher: AnyPublisher<String, Never> {
        publisher(for: \.lastCountryCodeUsed)
            .compactMap { $0 }
            .decode(
                type: String.self,
                decoder: JSONDecoder()
            )
            .replaceError(with: "")
            .eraseToAnyPublisher()
    }

    var recentNumbersPublisher: AnyPublisher<[RecentNumber], Never> {
        publisher(for: \.recentNumbers)
            .compactMap { $0 }
            .decode(
                type: [RecentNumber].self,
                decoder: JSONDecoder()
            )
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
