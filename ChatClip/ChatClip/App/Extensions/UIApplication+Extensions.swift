//
//  UIApplication+Extensions.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import Foundation
import UIKit

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func goToSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            open(settingsUrl)
        }
    }
}
