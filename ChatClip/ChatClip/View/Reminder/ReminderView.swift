//
//  ReminderView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct ReminderView: View {
    
    // MARK: Properties
    
    @State private var showReminderSheet: Bool = false
    
    var viewModel: ReminderViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.reminders, id: \.id) { reminder in
                    Button {
                        viewModel.chat(with: reminder)
                    } label: {
                        reminderView(reminder)
                            .swipeActions(edge: .leading) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "pencil")
                                }
                            }
                            .tint(.blue)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                            .tint(.red)
                    }
                    .listRowBackground(Color.secondaryBackground)
                }
            }
            .listRowSpacing(20)
            .scrollContentBackground(.hidden)
        }
        .padding(.vertical)
        .background(Color.secondaryAccentColor)
        .overlay(alignment: .topLeading) {
            Button {
                showReminderSheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(Color.accent)
                    .frame(width: 40, height: 40)
            }
        }
        .sheet(isPresented: $showReminderSheet) {
            ReminderFormView(showReminderSheet: $showReminderSheet, viewModel: viewModel.reminderFormViewModel)
                .presentationDetents([.large])
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    // MARK: List Component
    
    func reminderView(_ reminder: Reminder) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let title = reminder.title {
                Text(title)
                    .font(.glacial(.bold, size: 17))
                    .lineLimit(1)
            }
            Text(reminder.number)
                .font(.glacial(.regular, size: 16))
            if let time = reminder.time {
                HStack {
                    Image(systemName: "alarm")
                    Text("8:15 AM")
                        .font(.glacial(.regular, size: 15))
                }
            }
            if let message = reminder.message {
                Text(message)
                    .font(.glacial(.regular, size: 14))
                    .lineLimit(2)
            }
        }
        .foregroundStyle(Color.primaryBackground)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 5)
    }
}

// MARK: - Preview

#Preview {
    TabView {
        ReminderView(viewModel: ReminderViewModel(apiService: APIClient(), notificationService: APINotificationClient()))
    }
}
