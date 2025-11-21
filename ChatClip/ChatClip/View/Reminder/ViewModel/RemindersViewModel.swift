//
//  ReminderViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Combine
import UIKit

@Observable
final class RemindersViewModel {

    // MARK: - Types

    enum State {
        case empty(message: String)
        case data(
            reminderCellViewModels: [ReminderCellViewModel]
        )
    }

    // MARK: - Properties

    private var cancellables: Set<AnyCancellable> = []

    private let notificationService: APINotificationService
    private let store: Store

    private(set) var state: State = .empty(message: String(localized: "No reminders created!"))

    var selectedReminder: Reminder?

    var reminderFormViewModel: ReminderFormViewModel {
        ReminderFormViewModel(
            notificationService: notificationService, store: store, reminder: selectedReminder)
    }

    // MARK: - Initialization

    init(
        store: Store,
        notificationService: APINotificationService
    ) {
        self.store = store
        self.notificationService = notificationService
        setupPublishers()
    }

    // MARK: - Methods

    func setupPublishers() {
        store.remindersPublishers
            .map { reminders in
                reminders.map { reminder in
                    ReminderCellViewModel(apiService: APIClient(), reminder: reminder)
                }
            }
            .sink(receiveValue: { [weak self] reminderCellViewModels in
                if reminderCellViewModels.isEmpty {
                    self?.state = .empty(message: String(localized: "No reminders created!"))
                } else {
                    self?.state = .data(reminderCellViewModels: reminderCellViewModels)
                }
            })
            .store(in: &cancellables)
    }

    // MARK: - Public API

    func checkNotificationsPermissions(completion: @escaping (Bool) -> Void) {
        notificationService.askForPermission(completion: completion)
    }

    func deleteReminder(_ reminder: Reminder) {
        do {
            try store.removeReminder(reminder)
        } catch {
            print("Unable to delete reminder \(reminder.id) \(error)")
            return
        }
        notificationService.removeNotification(reminder)
    }

    func editReminder(_ reminder: Reminder) {
        selectedReminder = reminder
    }

    func createNewReminder() {
        selectedReminder = nil
    }

    func goToSettings() {
        UIApplication.shared.goToSettings()
    }
}
