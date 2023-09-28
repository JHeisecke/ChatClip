//
//  ChatView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import SwiftUI

struct ChatView: View {
    
    @Bindable var viewModel: ChatViewModel
    
    // Interface Style
    @AppStorage("toggleDarkMode") private var toggleDarkMode: Bool = false
    @AppStorage("activateDarkMode") private var activateDarkMode: Bool = false
    @State private var buttonRect: CGRect = .zero
    // Current & PRevious State Images
    @State private var currentImage: UIImage?
    @State private var previousImage: UIImage?
    @State private var maskAnimation: Bool = false
    
    var body: some View {
        chatClip
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
                    .accentColor(Color.theme)
                    .foregroundStyle(Color.theme)
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
    
    var chatClip: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
            GeometryReader { proxy in
                let width = proxy.size.width*0.8
                let height = proxy.size.height*0.3
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: width, height: height)
                        .foregroundColor(Color.bone)
                        .padding(.bottom)
                        .overlay {
                            floatingCard(width: width)
                        }
                        .shadow(radius: 10)
                        .overlay(alignment: .top) {
                            Text("chatclip")
                                .foregroundColor(Color.tealGreenDark)
                                .font(.glacial(.bold, size: 50))
                                .foregroundColor(.cyan)
                                .offset(y: -49)
                            
                        }
                    Button {
                        viewModel.chat()
                    } label: {
                        Text("send")
                            .font(.glacial(.regular, size: 18))
                            .foregroundColor(Color.tealGreenDark)
                            .padding()
                            .background(viewModel.disableButton ? Color.bone : Color.lime)
                            .cornerRadius(10)
                            .padding(5)
                    }
                    .disabled(viewModel.disableButton)
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea()
        .ignoresSafeArea(.keyboard)
        .onAppear {
            //TODO: viewModel.getCountryPhoneCodes()
        }
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }
    
    func floatingCard(width: CGFloat) -> some View {
        VStack {
            Text("label.help")
                .font(.glacial(.regular, size: 18))
                .foregroundColor(.black)
                .padding(.vertical)
            HStack {
                TextField(
                    "",
                    text: $viewModel.countryCode,
                    prompt:
                        Text("label.countryCode")
                        .foregroundColor(.bone)
                )
                .keyboardType(.numberPad)
                .font(.glacial(.regular, size: 18))
                .textFieldStyle(ChatClipTextFieldStyle())
                .frame(width: width*0.30)
                .foregroundColor(.tealGreenDark)
                TextField(
                    "",
                    text: $viewModel.phoneNumber,
                    prompt:
                        Text("label.number")
                        .foregroundColor(.bone)
                )
                .foregroundColor(.tealGreenDark)
                .font(.glacial(.regular, size: 18))
                .textFieldStyle(ChatClipTextFieldStyle())
                .keyboardType(.numberPad)
            }
            TextField(
                "",
                text: $viewModel.message,
                prompt:
                    Text("label.message")
                    .foregroundColor(.bone),
                axis: .vertical
            )
            .lineLimit(1...5)
            .foregroundColor(.tealGreenDark)
            .textFieldStyle(ChatClipTextFieldStyle())
            .font(.glacial(.regular, size: 18))
            Spacer()
        }
        .padding()
    }
    
}

// MARK: - Preview

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(viewModel: ChatViewModel(apiService: APIClient()))
            .environment(\.locale, .init(identifier: "en"))
    }
}
