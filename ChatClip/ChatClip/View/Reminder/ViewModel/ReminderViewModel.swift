//
//  ReminderViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation

@Observable
final class ReminderViewModel {
    
    // MARK: - Properties

    private(set) var reminders: RemindersList = AppData.reminders
    
    var reminderCellViewModels: [ReminderCellViewModel] {
        reminders.map { ReminderCellViewModel(apiService: APIClient(), reminder: $0) }
    }
    
    var reminderFormViewModel: ReminderFormViewModel {
        ReminderFormViewModel(apiService: APINotificationClient(), reminder: nil)
    }
    
    private let notificationService: APINotificationService
    
    // MARK: - Initialization

    init(notificationService: APINotificationService) {
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
    
    
    func deleteReminder(_ reminder: Reminder) {
        reminders.removeAll(where: { $0.id == reminder.id })
        AppData.reminders = reminders
        notificationService.removeNotification(reminder)
    }
    
    func editReminder() {
        
    }
}
