//
//  ChatViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation

struct ChatViewModel {
    
    // MARK: - Properties

    private let apiService: APIService
    
    // MARK: - Initialization

    init(apiService: APIService) {
        self.apiService = apiService
    }

    // MARK: - Public API
    
    func chat(to phoneNumber: String, with countryCode: String, send message: String) {
        let completeNumber = countryCode == "" ? "+595" : countryCode + phoneNumber
        apiService.sendWhatsappMessage(to: completeNumber, with: message)
    }
}
