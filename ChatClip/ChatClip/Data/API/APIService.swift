//
//  APIService.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation

protocol APIService {
    
    // MARK: - Methods
    
    func sendWhatsappMessage(to phoneNumber: String, with countryCode: String, text message: String?)
    
    func getCountryCodes() async throws -> CountryPhoneCodes
}
