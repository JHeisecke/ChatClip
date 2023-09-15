//
//  API.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import UIKit

struct API {
    func sendWhatsappMessage(to phoneNumber: String, with message: String?) {
        if let url = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)&text=\(message?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            // Open the WhatsApp chat in the default web browser or the WhatsApp app if it's installed.
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
