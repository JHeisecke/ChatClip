//
//  API.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import UIKit

struct API {
    func sendWhatsappMessage(to phoneNumber: String, with message: String?) {
        if let url = URL(string: Endpoints.initiateWhatsApp(with: phoneNumber, send: message)) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
