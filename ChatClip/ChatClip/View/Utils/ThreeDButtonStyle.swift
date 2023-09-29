//
//  ThreeDButtonStyle.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct ThreeDButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            
            let offset: CGFloat = 5
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.grayedBlue)
                .offset(y: offset)
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.niceBlue)
                .offset(y: configuration.isPressed ? offset : 0)
            
            configuration.label
                .offset(y: configuration.isPressed ? offset : 0)
        }
        .compositingGroup()
        .shadow(radius: 6, y:4)
    }
}

#Preview {
    Button("Button") {
        
    }
    .frame(width: 200, height: 50)
    .foregroundStyle(.white)
    .buttonStyle(ThreeDButtonStyle())
}
