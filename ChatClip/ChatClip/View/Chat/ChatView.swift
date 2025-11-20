//
//  ChatView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import SwiftUI

struct ChatView: View {

    @State var viewModel: ChatViewModel
    @State private var showCountryPicker = false

    var body: some View {
        chatClip
            .onAppear {
                viewModel.onAppear()
            }
    }

    var chatClip: some View {
        ZStack {
            Image("BackgroundImage")
                .resizable()
            GeometryReader { proxy in
                let width = proxy.size.width * 0.8
                let height = proxy.size.height * 0.3
                VStack {
                    Spacer()

                    VStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: width, height: height)
                            .foregroundStyle(Color.otherBackground)
                            .padding(.bottom)
                            .overlay {
                                floatingCard(width: width)
                            }
                            .shadow(radius: 10)
                            .overlay(alignment: .top) {
                                Text("ChatClip")
                                    .foregroundColor(Color.tealGreenDark)
                                    .font(.glacial(.bold, size: 50))
                                    .foregroundColor(.cyan)
                                    .offset(y: -49)

                            }
                        Button {
                            viewModel.chat()
                        } label: {
                            Text("Send Message")
                                .font(.glacial(.regular, size: 18))
                                .foregroundColor(Color.tealGreenDark)
                                .padding()
                                .background(
                                    viewModel.disableButton ? Color.otherBackground : Color.lime
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(5)
                        }
                        .disabled(viewModel.disableButton)
                    }

                    recentsView
                        .padding(.bottom, 20)

                    Spacer()
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .frame(maxWidth: .infinity)
        }
        .ignoresSafeArea()
        .ignoresSafeArea(.keyboard)
        .sheet(isPresented: $showCountryPicker) {
            CountryCodePicker(
                countries: viewModel.countryCodes, selectedCountryCode: $viewModel.countryCode)
        }
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }

    // MARK: - Floating Card

    func floatingCard(width: CGFloat) -> some View {
        VStack {
            Spacer()
            Text("Send a Whatsapp message to an unsaved number")
                .font(.glacial(.regular, size: 18))
                .foregroundColor(Color.primaryBackground)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack {
                Button {
                    showCountryPicker = true
                } label: {
                    Text(viewModel.countryCode.isEmpty ? "+1" : viewModel.countryCode)
                        .font(.glacial(.regular, size: 17))
                        .foregroundColor(Color.primaryBackground)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                }
                .frame(width: width * 0.26, height: 45)
                .background(Color.otherBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))

                TextField(
                    "",
                    text: $viewModel.phoneNumber,
                    prompt:
                        Text("Phone Number")
                        .foregroundStyle(Color.otherAccent)
                )
                .foregroundStyle(Color.primaryBackground)
                .font(.glacial(.regular, size: 17))
                .textFieldStyle(ChatClipTextFieldStyle())
                .keyboardType(.numberPad)
            }

            HStack {
                Spacer()
                Button {
                    viewModel.paste()
                } label: {
                    Label("Paste", systemImage: "doc.on.clipboard")
                        .font(.glacial(.regular, size: 14))
                        .foregroundColor(.tealGreenDark)
                }
                .padding(.bottom, 5)
            }

            TextField(
                "",
                text: $viewModel.message,
                prompt:
                    Text("Message (Optional)")
                    .foregroundStyle(Color.otherAccent),
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

    @ViewBuilder
    var recentsView: some View {
        if !viewModel.recentNumbers.isEmpty {
            VStack(alignment: .leading) {
                Text("Recents")
                    .font(.glacial(.bold, size: 18))
                    .foregroundColor(.tealGreenDark)
                    .padding(.leading)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.recentNumbers, id: \.self) { recent in
                            Button {
                                viewModel.countryCode = recent.countryCode
                                viewModel.phoneNumber = recent.phoneNumber
                            } label: {
                                Text("\(recent.countryCode) \(recent.phoneNumber)")
                                    .font(.glacial(.regular, size: 14))
                                    .foregroundColor(.tealGreenDark)
                                    .padding(8)
                                    .background(Color.otherBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(radius: 2)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.top)
        }
    }

}

// MARK: - Preview

#Preview {
    ChatView(viewModel: ChatViewModel(apiService: APIClient(), store: PreviewsStore()))
        .environment(\.locale, .init(identifier: "es"))
}
