//
//  API.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import UIKit

struct APIClient: APIService {
    
    func sendWhatsappMessage(to phoneNumber: String, with countryCode: String, text message: String?) {
        let completedNumber = "\(countryCode)\(phoneNumber)"
        if let url = URL(string: Endpoints.initiateWhatsApp(with: completedNumber, send: message)) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func getCountryCodes() async throws -> CountryPhoneCodes {
        guard let url = Bundle.main.url(forResource: "country_codes", withExtension: "json") else {
            fatalError("Unable to Find country_codes.json")
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(CountryPhoneCodes.self, from: data)
    }
    
}
