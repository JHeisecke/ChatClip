//
//  MenuViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation

final class MenuViewModel {
    
    /// Because we navigate from the cell to the location's view, we create the view model here
    var chatViewModel: ChatViewModel {
        .init(apiService: APIClient(), store: UserDefaults.standard)
    }
    
    var reminderViewModel: RemindersViewModel {
        .init(store: UserDefaults.standard, notificationService: APINotificationClient())
    }
}
