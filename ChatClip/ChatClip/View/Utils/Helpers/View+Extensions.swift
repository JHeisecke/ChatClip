//
//  View+Extensions.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

extension View {
    
    /// returns view's position in the screen coordinate space
    @ViewBuilder 
    func rect(value: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { geometry in
                    let rect  = geometry.frame(in: .global)
                    
                    Color.clear
                        .preference(key: RectKey.self, value: rect)
                        .onPreferenceChange(RectKey.self, perform: { rect in
                            value(rect)
                        })
                }
        }
    }
    
    /// Captures the views by finding the active key window via UIApplication connectedSessions
    @MainActor
    @ViewBuilder
    func createImages(toggleDarkMode: Bool, currentImage: Binding<UIImage?>, previousImage: Binding<UIImage?>, activateDarkMode: Binding<Bool>) -> some View {
        self
            .onChange(of: toggleDarkMode) { oldValue, newValue in
                Task {
                    if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow}) {
                        
                        /// dummy view to prevent flickering
                        let imageView = UIImageView()
                        imageView.frame = window.frame
                        imageView.image = window.rootViewController?.view.image(window.frame.size)
                        imageView.contentMode = .scaleAspectFit
                        window.addSubview(imageView)
                        
                        if let rootView = window.rootViewController?.view {
                            let frameSize = rootView.frame.size
                            /// Creates snapshot of previous state
                            activateDarkMode.wrappedValue = !newValue
                            previousImage.wrappedValue = rootView.image(frameSize)
                            /// Creates snapshot of current state
                            activateDarkMode.wrappedValue = newValue
                            try await Task.sleep(for: .seconds(0.01))
                            currentImage.wrappedValue = rootView.image(frameSize)
                            /// Removing dummy view
                            try await Task.sleep(for: .seconds(0.01))
                            imageView.removeFromSuperview()
                        }
                    }
                }
            }
    }
}

// MARK: - UIView

extension UIView {
    func image(_ size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            drawHierarchy(in: .init(origin: .zero, size: size), afterScreenUpdates: true)
        }
    }
}
