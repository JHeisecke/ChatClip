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
    
    // Form
    @State private var useDate: Bool = false
    @State private var useTime: Bool = false
    @State private var title: String = ""
    @State private var phoneNumber: String = ""
    @State private var message: String = ""
    @State private var remindMeAt: Date = Date()
    
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
                    .listRowBackground(Color.bone)
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
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 40, height: 40)
            }
        }
        .sheet(isPresented: $showReminderSheet) {
            reminderSheet()
                .presentationDetents([.large])
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
    
    // MARK: Sheet View
    
    func reminderSheet() -> some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                }

                Section {
                    TextField("label.number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                    TextField("label.message", text: $message)
                } header: {
                    Text("Text")
                }
                
                Section {
                    Toggle(isOn: $useDate) {
                        Label("Date", systemImage: "calendar")
                    }
                    Toggle(isOn: $useTime) {
                        Label("Time", systemImage: "clock")
                    }
                } header: {
                    Text("Remind me at:")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showReminderSheet.toggle()
                        //TODO: Save reminder
                    } label: {
                        Text("Save")
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Details")
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showReminderSheet.toggle()
                        useDate = false
                        useTime = false
                        title = ""
                        phoneNumber = ""
                        message = ""
                        remindMeAt = Date()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        ReminderView(viewModel: ReminderViewModel(apiService: APIClient()))
    }
}
