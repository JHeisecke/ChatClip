//
//  ReminderCellViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-06.
//

import Foundation

final class ReminderCellViewModel {
    
    // MARK: - Properties
    
    private let reminder: Reminder
    
    
    // MARK: - Initialization
    
    init(reminder: Reminder) {
        self.reminder = reminder
    }
    
    var reminderTitle: String? {
        reminder.title
    }
    
    var reminderRecipient: String {
        reminder.number
    }
    
    var reminderTime: String? {
        "Today"
    }
    
    var reminderMessage: String? {
        reminder.message
    }
}
