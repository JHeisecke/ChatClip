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
        store: Store,
        reminder: Reminder? = nil
    ) {
        self.notificationService = notificationService
        self.store = store
        self.reminder = reminder

        if let reminder {
            self.title = reminder.title ?? ""
            self.phoneNumber = reminder.number
            self.message = reminder.message ?? ""
            if let time = reminder.time {
                self.useDate = true
                self.reminderDate = time
            }
        }
    }

    // MARK: - Methods

    func resetVariables() {
        title = ""
        phoneNumber = ""
        message = ""
        reminderDate = Date()
        reminder = nil
    }

    func saveReminder() {
        // If editing, remove the old reminder first
        if let existingReminder = reminder {
            try? store.removeReminder(existingReminder)
            notificationService.removeNotification(existingReminder)
        }

        let newReminder = Reminder(
            id: "\(reminderDate.timeIntervalSince1970)", number: phoneNumber, title: title,
            time: useDate ? reminderDate : nil, message: message)
        notificationService.scheduleAlert(
            newReminder,
            completion: { [weak self] result in
                guard let self else { return }
                do {
                    try store.addReminder(newReminder)
                } catch {
                    print("Unable to save reminder \(newReminder). \(error)")
                    self.notificationService.removeNotification(newReminder)
                }
                resetVariables()
            })
    }
}
