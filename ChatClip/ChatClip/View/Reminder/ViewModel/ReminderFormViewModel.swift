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
    
    private let apiService: APIService
    
    var remindMeTime: String {
        reminderDate.formatted(date: .abbreviated, time: .shortened)
    }
    
    // MARK: - Initialization

    init(apiService: APIService, reminder: Reminder?) {
        self.apiService = apiService
        self.reminder = reminder
    }
}
