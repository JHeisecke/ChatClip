//
//  RecentsView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-11-20.
//

import SwiftUI

struct RecentsView: View {
    @Bindable var viewModel: ChatViewModel

    let columns = [
        GridItem(.adaptive(minimum: 120))
    ]

    var body: some View {
        if !viewModel.recentNumbers.isEmpty {
            VStack(alignment: .leading) {
                HStack {
                    Text("Recents")
                        .font(.glacial(.bold, size: 18))
                        .foregroundStyle(Color.tealGreenDark)

                    Spacer()

                    Button {
                        withAnimation {
                            viewModel.clearAllRecents()
                        }
                    } label: {
                        Text("Clear All")
                            .font(.glacial(.regular, size: 14))
                            .foregroundStyle(.red)
                            .padding(8)
                            .background(Color.otherBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.recentNumbers, id: \.self) { recent in
                            Button {
                                viewModel.countryCode = recent.countryCode
                                viewModel.phoneNumber = recent.phoneNumber
                            } label: {
                                Text("\(recent.countryCode) \(recent.phoneNumber)")
                                    .font(.glacial(.regular, size: 14))
                                    .foregroundStyle(Color.tealGreenDark)
                                    .padding(8)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.otherBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                            }
                            .contextMenu {
                                Button(role: .destructive) {
                                    withAnimation {
                                        viewModel.deleteRecentNumber(recent)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: 150)  // Limit height to avoid taking up too much space
            }
            .padding(.top)
        }
    }
}
