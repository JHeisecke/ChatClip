//
//  ChatViewModel.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Combine
import SwiftUI

@Observable
final class ChatViewModel {

    // MARK: - Properties

    @ObservationIgnored
    private var cancellables: Set<AnyCancellable> = []

    @ObservationIgnored
    private let apiService: APIService
    @ObservationIgnored
    private let store: Store

    private(set) var countryCodes: CountryPhoneCodes = []
    private(set) var recentNumbers: [RecentNumber] = []

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
        getCountryPhoneCodes()
        store.lastCountryCodeUsedPublisher
            .sink { [weak self] in
                self?.countryCode = $0
            }
            .store(in: &cancellables)

        store.recentNumbersPublisher
            .sink { [weak self] in
                self?.recentNumbers = $0
            }
            .store(in: &cancellables)
    }

    func chat() {
        if let firstNumber = phoneNumber.first, firstNumber == "0" {
            phoneNumber.removeFirst()
        }
        try? store.addLastCountryCodeUsed(countryCode)
        try? store.addRecentNumber(
            RecentNumber(countryCode: countryCode, phoneNumber: phoneNumber, date: Date()))
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

    func paste() {
        guard let string = UIPasteboard.general.string else { return }
        let cleaned = string.filter { $0.isNumber || $0 == "+" }

        // Try to find a matching country code
        // Sort by length descending to match longest code first (e.g. +1 vs +1242)
        let sortedCodes = countryCodes.sorted { $0.dialCode.count > $1.dialCode.count }

        for country in sortedCodes {
            if cleaned.hasPrefix(country.dialCode) {
                countryCode = country.dialCode
                phoneNumber = String(cleaned.dropFirst(country.dialCode.count))
                return
            }
        }

        // If no code matches, just paste into phone number
        phoneNumber = cleaned.filter { $0.isNumber }
    }

    func deleteRecentNumber(_ recent: RecentNumber) {
        try? store.removeRecentNumber(recent)
    }

    func clearAllRecents() {
        try? store.clearAllRecentNumbers()
    }
}
