//
//  FloatingCardView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-11-20.
//

import SwiftUI

struct FloatingCardView: View {
    @Bindable var viewModel: ChatViewModel
    @Binding var showCountryPicker: Bool
    let width: CGFloat

    var body: some View {
        VStack {
            Spacer()
            Text("Send a Whatsapp message to an unsaved number")
                .font(.glacial(.regular, size: 18))
                .foregroundStyle(Color.primaryBackground)
                .lineLimit(5)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack {
                Button {
                    showCountryPicker = true
                } label: {
                    Text(viewModel.countryCode.isEmpty ? "+1" : viewModel.countryCode)
                        .font(.glacial(.regular, size: 17))
                        .foregroundStyle(Color.primaryBackground)
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
                        .foregroundStyle(Color.tealGreenDark)
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
            .foregroundStyle(Color.tealGreenDark)
            .textFieldStyle(ChatClipTextFieldStyle())
            .font(.glacial(.regular, size: 18))
            Spacer()
        }
        .padding()
    }
}
