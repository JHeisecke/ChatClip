//
//  ReminderViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation
import Combine

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
    
    private let notificationService: APINotificationService
    private let store: Store
    
    private(set) var state: State = .empty(message: String(localized: "No reminders created!"))
        
    private var cancellables: Set<AnyCancellable> = []
    
    var reminderFormViewModel: ReminderFormViewModel {
        ReminderFormViewModel(notificationService: notificationService, store: store)
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
    
    func onAppear() {
        getNotificationPermission()
    }
    
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
    
    func getNotificationPermission() {
        notificationService.askForPermission { granted in
            if granted {
                print(granted)
            } else {
                print(granted)
            }
        }
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
    
    func editReminder() {
        //TODO: Edit Reminder
    }
}
