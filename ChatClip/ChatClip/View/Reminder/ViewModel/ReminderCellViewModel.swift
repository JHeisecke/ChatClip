//
//  ReminderCellViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-06.
//

import Foundation

final class ReminderCellViewModel: Identifiable {
    
    // MARK: - Properties
    private let apiService: APIService
    //TODO: set private
    let reminder: Reminder
    
    var id: String {
        reminder.id
    }
    
    var reminderTitle: String? {
        reminder.title
    }
    
    var reminderRecipient: String {
        reminder.number
    }
    
    var reminderTime: String? {
        reminder.time?.formatted(date: .abbreviated, time: .shortened)
    }
    
    var reminderMessage: String? {
        reminder.message
    }
    
    // MARK: - Initialization
    
    init(apiService: APIService, reminder: Reminder) {
        self.apiService = apiService
        self.reminder = reminder
    }

    // MARK: - Methods
    
    func chat() {
        apiService.sendWhatsappMessage(to: reminder.number, with: "", text: reminder.message)
    }
}
