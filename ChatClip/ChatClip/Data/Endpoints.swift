//
//  Endpoints.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation

struct Endpoints {
    static func initiateWhatsApp(with phoneNumber: String, send message: String?) -> String {
        "https://api.whatsapp.com/send?phone=\(phoneNumber)&text=\(message?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
    }
}
