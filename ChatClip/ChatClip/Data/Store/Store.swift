//
//  Store.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-16.
//

import Combine

protocol Store {
    var lastCountryCodeUsedPublisher: AnyPublisher<String, Never> { get }
    var remindersPublishers: AnyPublisher<RemindersList, Never> { get }
    
    func addLastCountryCodeUsed(_ countryCode: String) throws
    func addReminder(_ reminder: Reminder) throws
    func removeReminder(_ reminder: Reminder) throws
    
}
