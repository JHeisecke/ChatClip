//
//  ReminderFormViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-06.
//

import Foundation

@Observable
final class ReminderFormViewModel {
    
    // MARK: - Properties
    
    var title = ""
    var phoneNumber = ""
    var message = ""
    var useDate = false
    var reminderDate = Date()
    
    private var reminder: Reminder?
    
    private let apiService: APINotificationService
    
    var remindMeTime: String {
        reminderDate.formatted(date: .abbreviated, time: .shortened)
    }
    
    // MARK: - Initialization

    init(apiService: APINotificationService, reminder: Reminder?) {
        self.apiService = apiService
        self.reminder = reminder
    }
    
    // MARK: - Methods

    func resetVariables() {
        title = ""
        phoneNumber = ""
        message = ""
        reminderDate = Date()
    }
    
    func saveReminder() {
        let reminder = Reminder(id: "\(reminderDate.timeIntervalSince1970)", number: phoneNumber, title: title, time: useDate ? reminderDate : nil, message: message)
        apiService.scheduleAlert(reminder, completion: { [weak self] result in
            guard let self else { return }
            AppData.reminders.append(reminder)
            resetVariables()
        })
    }
}
