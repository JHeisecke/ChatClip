//
//  CountryPhone.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation

typealias CountryPhoneCodes = [CountryPhone]

struct CountryPhone: Codable {
    let name: String
    let dialCode: String
    let code: String
    let emoji: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case dialCode = "dial_code"
        case code
        case emoji
    }
}
