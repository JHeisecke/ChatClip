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
        ReminderFormViewModel(apiService: APINotificationClient(), reminder: nil)
    }
    
    private let apiService: APIService
    private let notificationService: APINotificationService
    
    // MARK: - Initialization

    init(apiService: APIService, notificationService: APINotificationService) {
        self.apiService = apiService
        self.notificationService = notificationService
    }
    
    // MARK: - Methods
    
    func onAppear() {
        notificationService.askForPermission { granted in
            if granted {
               print(granted)
            } else {
                print(granted)
            }
        }
    }
    
    func chat(with reminder: Reminder) {
        apiService.sendWhatsappMessage(to: reminder.number, with: "", text: reminder.message)
    }
    
}
