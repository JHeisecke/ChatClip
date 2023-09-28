//
//  RectKey.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct RectKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}
