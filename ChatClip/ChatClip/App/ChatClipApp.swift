//
//  ChatClipApp.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import SwiftUI

@main
struct ChatClipApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: ChatViewModel(apiService: APIClient()))
        }
    }
}
