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
    
    private let notificationService: APINotificationService
    private let store: Store
    
    var remindMeTime: String {
        reminderDate.formatted(date: .abbreviated, time: .shortened)
    }
    
    // MARK: - Initialization

    init(
        notificationService: APINotificationService,
        store: Store
    ) {
        self.notificationService = notificationService
        self.store = store
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
        notificationService.scheduleAlert(reminder, completion: { [weak self] result in
            guard let self else { return }
            do {
                try store.addReminder(reminder)
            } catch {
                print("Unable to save reminder \(reminder). \(error)")
                self.notificationService.removeNotification(reminder)
            }
            resetVariables()
        })
    }
}
