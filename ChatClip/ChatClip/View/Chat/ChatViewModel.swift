//
//  ChatViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation
import Combine

@Observable
final class ChatViewModel {
    
    // MARK: - Properties
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let apiService: APIService
    private let store: Store
    
    private(set) var countryCodes: CountryPhoneCodes = []
    
    var countryCode = ""
    var message = ""
    var phoneNumber = "" {
        didSet {
            let filtered = phoneNumber.filter { $0.isNumber }
            
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
        }
    }
    
    var disableButton: Bool {
        return phoneNumber == "" || phoneNumber == "0"
    }
    
    // MARK: - Initialization
    
    init(apiService: APIService, store: Store) {
        self.apiService = apiService
        self.store = store
    }
    
    // MARK: - Public API
    
    func onAppear() {
        store.lastCountryCodeUsedPublisher
            .sink { [weak self] in
                self?.countryCode = $0
            }
            .store(in: &cancellables)
    }
    
    func chat() {
        if let firstNumber = phoneNumber.first, firstNumber == "0" {
            phoneNumber.removeFirst()
        }
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
