//
//  ReminderViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation

final class ReminderViewModel {
    
    // MARK: - Properties

    private(set) var reminders: RemindersList = AppData.reminders
    
    var reminderCellViewModels: [ReminderCellViewModel] {
        Reminder.previews.map(ReminderCellViewModel.init)
    }
    
    var reminderFormViewModel: ReminderFormViewModel {
        ReminderFormViewModel(apiService: APIClient(), reminder: nil)
    }
    
    private let apiService: APIService
    
    // MARK: - Initialization

    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    // MARK: - Public API
    
    func chat(with reminder: Reminder) {
        apiService.sendWhatsappMessage(to: reminder.number, with: "", text: reminder.message)
    }
    
}
