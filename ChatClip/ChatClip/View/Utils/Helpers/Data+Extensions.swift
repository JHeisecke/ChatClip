//
//  Data+Extensions.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation

// MARK: - DateFormatter

extension DateFormatter {

    func dateToString_yyyyMMddTHHmm(_ value: Date?) -> String? {
        guard let value = value else { return nil }
        timeZone = TimeZone(secondsFromGMT: 0)
        locale = Locale(identifier: "en_US_POSIX")
        dateFormat = DateFormats.ddMMyyyyHHmm
        return string(from: value)
    }
    
}
