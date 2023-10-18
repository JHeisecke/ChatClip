//
//  MenuView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct MenuView: View {
    
    var viewModel: MenuViewModel
    
    // MARK: - Properties
    
    @State private var activeTab: Int = 0
    
    // Interface Style
    @AppStorage("toggleDarkMode") private var toggleDarkMode: Bool = false
    @AppStorage("activateDarkMode") private var activateDarkMode: Bool = false
    @State private var buttonRect: CGRect = .zero
    
    // Current & PRevious State Images
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    
    var body: some View {
        TabView(selection: $activeTab) {
            ChatView(
                viewModel: viewModel.chatViewModel
            )
            .tabItem {
                Label("Chat", systemImage: "paperclip")
            }
            .tag(1)
            RemindersView(
                viewModel: viewModel.reminderViewModel
            )
            .tabItem {
                Label("Reminders", systemImage: "bell.fill")
            }
            .tag(2)
        }
        .tint(Color.accent)
        .createImages(
            toggleDarkMode: toggleDarkMode,
            currentImage: $currentImage,
            previousImage: $previousImage,
            activateDarkMode: $activateDarkMode
        )
        .overlay {
            GeometryReader { geometry in
                let size = geometry.size
                
                if let previousImage, let currentImage {
                    ZStack {
                        Image(uiImage: previousImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                        
                        Image(uiImage: currentImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size.width, height: size.height)
                            .mask(alignment: .topLeading) {
                                Circle()
                                    .frame(width: buttonRect.width * (maskAnimation ? 80 : 1), height: buttonRect.height * (maskAnimation ? 80 : 1), alignment: .bottomLeading)
                                    .frame(width: buttonRect.width, height: buttonRect.height)
                                    .offset(x: buttonRect.minX, y: buttonRect.minY)
                                    .ignoresSafeArea()
                            }
                    }
                    .task {
                        guard !maskAnimation else { return }
                        withAnimation(.easeInOut(duration: 0.9), completionCriteria: .logicallyComplete) {
                            maskAnimation = true
                        } completion: {
                            self.currentImage = nil
                            self.previousImage = nil
                            maskAnimation = false
                        }
                    }
                }
            }
            /// Reverse masking, to hide the button in the snapshot
            .mask({
                Rectangle()
                    .overlay(alignment: .topLeading) {
                        Circle()
                            .frame(width: buttonRect.width, height: buttonRect.height)
                            .offset(x: buttonRect.minX, y: buttonRect.minY)
                            .blendMode(.destinationOut)
                    }
            })
            .ignoresSafeArea()
        }
        .overlay(alignment: .topTrailing) {
            Button {
                /// Whenever the mode is changed, the current and previous state of the view will be captured. Once the snapshots have been taken, they'll be used as an overlay view to smoothly transition from one state to another via the masking effect
                toggleDarkMode.toggle()
            } label: {
                Image(systemName: toggleDarkMode ? "sun.max.fill" : "moon.fill")
                    .font(.title2)
                    .foregroundStyle(Color.primaryBackground)
                    .symbolEffect(.bounce, value: toggleDarkMode)
                    .frame(width: 40, height: 40)
            }
            .rect { rect in
                buttonRect = rect
            }
            .padding(10)
            .disabled(currentImage != nil || previousImage != nil || maskAnimation)
        }
        .preferredColorScheme(activateDarkMode ? .dark : .light)
    }
}

#Preview {
    MenuView(viewModel: MenuViewModel())
}
