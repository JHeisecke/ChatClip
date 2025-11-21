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
            backgroundImage

            GeometryReader { proxy in
                let width = proxy.size.width * 0.8
                let height = proxy.size.height * 0.3

                VStack {
                    Spacer()

                    VStack {
                        mainCard(width: width, height: height)
                        sendButton
                    }

                    RecentsView(viewModel: viewModel)
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

    var backgroundImage: some View {
        Image("BackgroundImage")
            .resizable()
    }

    func mainCard(width: CGFloat, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 30)
            .frame(width: width, height: height)
            .foregroundStyle(Color.otherBackground)
            .padding(.bottom)
            .overlay {
                FloatingCardView(
                    viewModel: viewModel,
                    showCountryPicker: $showCountryPicker,
                    width: width
                )
            }
            .shadow(radius: 10)
            .overlay(alignment: .top) {
                headerTitle
            }
    }

    var headerTitle: some View {
        Text("ChatClip")
            .foregroundStyle(Color.tealGreenDark)
            .font(.glacial(.bold, size: 50))
            .foregroundStyle(.cyan)
            .offset(y: -49)
    }

    var sendButton: some View {
        Button {
            viewModel.chat()
        } label: {
            Text("Send Message")
                .font(.glacial(.regular, size: 18))
                .foregroundStyle(Color.tealGreenDark)
                .padding()
                .background(
                    viewModel.disableButton ? Color.otherBackground : Color.lime
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(5)
        }
        .disabled(viewModel.disableButton)
    }
}

// MARK: - Preview

#Preview {
    ChatView(viewModel: ChatViewModel(apiService: APIClient(), store: PreviewsStore()))
        .environment(\.locale, .init(identifier: "es"))
}
