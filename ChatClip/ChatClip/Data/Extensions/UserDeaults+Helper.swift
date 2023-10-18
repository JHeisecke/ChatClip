//
//  UserDeaults+Helper.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-16.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let reminders = "reminders"
        static let lastCountryCodeUsed = "lastCountryCodeUsed"
    }
    
    // MARK: - Reminders
    
    @objc var reminders: Data? {
        get {
            data(forKey: Keys.reminders)
        }
        set {
            set(newValue, forKey: Keys.reminders)
        }
    }
    
    func addReminder(_ reminder: Reminder) throws {
        var reminders: RemindersList = try decode(
            [Reminder].self,
            forKey: Keys.reminders
        ) ?? []
        
        reminders.append(reminder)
        
        try encode(reminders, forKey: Keys.reminders)
        
    }
    
    func removeReminder(_ reminder: Reminder) throws {
        var reminders: RemindersList = try decode(
            [Reminder].self,
            forKey: Keys.reminders
        ) ?? []
        
        reminders.removeAll { $0.id == reminder.id }
        
        try encode(reminders, forKey: Keys.reminders)
    }
    
    // MARK: - Last Country Code USed
    
    @objc var lastCountryCodeUsed: Data? {
        get {
            data(forKey: Keys.lastCountryCodeUsed)
        }
        set {
            set(newValue, forKey: Keys.lastCountryCodeUsed)
        }
    }
    
    func addLastCountryCodeUsed(_ countryCode: String) throws {
        try encode(countryCode, forKey: Keys.lastCountryCodeUsed)
    }
    
}

fileprivate extension UserDefaults {
    
    func decode<T: Decodable>(_ type: T.Type, forKey key: String) throws -> T? {
        guard let data = data(forKey: key) else {
            return nil
        }
        
        return try? JSONDecoder().decode(type, from: data)
    }
    
    func encode<T: Encodable>(_ value: T, forKey key: String) throws {
        let data = try JSONEncoder().encode(value)
        set(data, forKey: key)
    }
}
