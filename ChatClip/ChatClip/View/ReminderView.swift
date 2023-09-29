//
//  ReminderView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct ReminderView: View {
    
    var viewModel: ReminderViewModel
    
    var body: some View {
        VStack {
            List {
                reminder
                    .swipeActions(edge: .leading) {
                        Button {
                            // TODO: Edit reminder
                        } label: {
                            Image(systemName: "pencil")
                        }
                        .tint(.blue)
                    }
                    .swipeActions(edge: .trailing) {
                        Button {
                            // TODO: Delete reminder
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(.red)
                    }
            }
            .listRowSpacing(20)
            .scrollContentBackground(.hidden)
//            Button("Add Reminder") {
//                
//            }
//            .frame(width: 300, height: 50)
//            .foregroundStyle(.white)
//            .font(.glacial(.bold, size: 19))
//            .buttonStyle(ThreeDButtonStyle())
//            .background(Color.clear)
        }
        .padding(.vertical)
        .background(Color.secondaryAccentColor)
        .overlay(alignment: .topLeading) {
            Button {
                // Popup add reminder
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 40, height: 40)
            }
        }
    }
    
    var reminder: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Text Mr. Roberts to fix the fan")
                .font(.glacial(.regular, size: 17))
                .lineLimit(1)
            Text("+595983458746")
                .font(.glacial(.regular, size: 16))
            HStack {
                Image(systemName: "alarm")
                Text("8:15 AM")
                    .font(.glacial(.regular, size: 15))
            }
            Text("Hi sir! I need to inform you that the fan stopped working since two days ago, I was hoping you could help with that. Thanks!")
                .font(.glacial(.regular, size: 14))
                .lineLimit(2)
        }
        .foregroundStyle(Color.primaryBackground)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 5)
        .listRowBackground(Color.bone)
    }
}

#Preview {
    TabView {
        ReminderView(viewModel: ReminderViewModel())
    }
}
