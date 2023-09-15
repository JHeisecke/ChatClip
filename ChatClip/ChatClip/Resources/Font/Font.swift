//
//  Font.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import SwiftUI

extension Font {
    enum GlacialIndifferenceFont {
        case bold
        case italic
        case regular

        var value: String {
            switch self {
            case .bold:
                return "GlacialIndifference-Bold"
            case .italic:
                return "GlacialIndifference-Italic"
            case .regular:
                return "GlacialIndifference-Regular"
            }
        }
    }

    static func glacial(_ type: GlacialIndifferenceFont, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
