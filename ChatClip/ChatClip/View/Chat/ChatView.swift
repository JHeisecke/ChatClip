//
//  ChatView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import SwiftUI

struct ChatView: View {
    
    @Bindable var viewModel: ChatViewModel
    
    var body: some View {
        chatClip
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
                        .foregroundColor(Color.secondaryBackground)
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
                            .background(viewModel.disableButton ? Color.secondaryBackground : Color.lime)
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
            Spacer()
            Text("label.help")
                .font(.glacial(.regular, size: 18))
                .foregroundColor(Color.primaryBackground)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack {
                TextField(
                    "",
                    text: $viewModel.countryCode,
                    prompt:
                        Text("label.countryCode")
                        .foregroundColor(Color.secondaryAccentColor)
                )
                .keyboardType(.numberPad)
                .font(.glacial(.regular, size: 18))
                .textFieldStyle(ChatClipTextFieldStyle())
                .frame(width: width*0.30)
                .foregroundColor(Color.primaryBackground)
                TextField(
                    "",
                    text: $viewModel.phoneNumber,
                    prompt:
                        Text("label.number")
                        .foregroundColor(Color.secondaryAccentColor)
                )
                .foregroundColor(Color.primaryBackground)
                .font(.glacial(.regular, size: 18))
                .textFieldStyle(ChatClipTextFieldStyle())
                .keyboardType(.numberPad)
            }
            TextField(
                "",
                text: $viewModel.message,
                prompt:
                    Text("label.message")
                    .foregroundColor(Color.secondaryAccentColor),
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

#Preview {
    ChatView(viewModel: ChatViewModel(apiService: APIClient(), store: PreviewsStore()))
            .environment(\.locale, .init(identifier: "en"))
}
