//
//  ChatView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-15.
//

import SwiftUI

struct ChatView: View {
    
    @State private var message: String = ""
    @State private var number: String = ""
    @State private var countryCode: String = ""
    
    var api: API
    
    var body: some View {
        ZStack {
            Color.tealGreen
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
                            VStack {
                                Spacer()
                                HStack {
                                    TextField(
                                        "",
                                        text: $countryCode,
                                        prompt:
                                            Text("label.countryCode")
                                            .foregroundColor(.bone)
                                    )
                                    .keyboardType(.numberPad)
                                    .font(.glacial(.regular, size: 18))
                                    .textFieldStyle(ChatClipTextFieldStyle())
                                    .frame(width: width*0.30)
                                    .foregroundColor(.black)
                                    TextField(
                                        "",
                                        text: $number,
                                        prompt:
                                            Text("label.number")
                                            .foregroundColor(.bone)
                                    )
                                    .font(.glacial(.regular, size: 18))
                                    .textFieldStyle(ChatClipTextFieldStyle())
                                    .keyboardType(.numberPad)
                                }
                                TextField(
                                    "",
                                    text: $message,
                                    prompt:
                                        Text("label.message")
                                        .foregroundColor(.bone)
                                )
                                .textFieldStyle(ChatClipTextFieldStyle())
                                .font(.glacial(.regular, size: 18))
                                Spacer()
                            }
                            .padding()
                        }
                        .shadow(radius: 10)
                        .overlay(alignment: .top) {
                            Text("chatclip")
                                .foregroundColor(Color.tealGreenDark)
                                .font(.glacial(.bold, size: 50))
                                .foregroundColor(.cyan)
                                .offset(y: -49)
                                .shadow(radius: 1)
                            
                        }
                    Button {
                        let countryCode = self.countryCode == "" ? "+595" : self.countryCode
                        api.sendWhatsappMessage(to: "\(countryCode)\(number)", with: message)
                    } label: {
                        Text("send")
                            .font(.glacial(.regular, size: 18))
                            .foregroundColor(Color.tealGreenDark)
                            .padding()
                            .background(Color.lime)
                            .cornerRadius(10)
                            .padding(5)
                    }
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
            }
        }
        .ignoresSafeArea()
        .ignoresSafeArea(.keyboard)
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(api: API())
            .environment(\.locale, .init(identifier: "en"))
    }
}
