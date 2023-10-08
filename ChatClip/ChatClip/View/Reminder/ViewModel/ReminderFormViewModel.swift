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
        print(title, phoneNumber, message, reminderDate)
        resetVariables()
        //TODO: Save Reminder
    }
}
