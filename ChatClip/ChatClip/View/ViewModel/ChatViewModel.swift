//
//  ChatViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation

final class ChatViewModel: ObservableObject {
    
    // MARK: - Properties

    @Published private(set) var countryCodes: CountryPhoneCodes = []
    
    @Published var countryCode = AppData.lastCountryCodeUsed ?? ""
    @Published var message = ""
    @Published var phoneNumber = "" {
        didSet {
            let filtered = phoneNumber.filter { $0.isNumber }
            
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
        }
    }
    
    private let apiService: APIService
    
    // MARK: - Initialization

    init(apiService: APIService) {
        self.apiService = apiService
    }

    // MARK: -
    
    var disableButton: Bool {
        return countryCode == "" || phoneNumber == ""
    }
    
    // MARK: - Public API
    
    func chat() {
        apiService.sendWhatsappMessage(to: phoneNumber, with: countryCode, text: message)
    }
    
    func getCountryPhoneCodes() {
        Task {
            do {
                countryCodes = try await apiService.getCountryCodes()
            } catch {
                print("Unable to read countries \(error)")
            }
        }
    }
}
