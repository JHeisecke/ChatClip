//
//  ReminderFormView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-29.
//

import SwiftUI

struct ReminderFormView: View {
    
    @Binding var showReminderSheet: Bool
    
    @State private var useDate: Bool = false
    
    @Bindable var viewModel: ReminderFormViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $viewModel.title)
                }

                Section {
                    HStack {
                        Text("+")
                        TextField("label.number", text: $viewModel.phoneNumber)
                            .keyboardType(.numberPad)
                    }
                    TextField("label.message", text: $viewModel.message)
                } header: {
                    Text("Text")
                }
                Section {
                    dateForm
                } header: {
                    Text("Remind me at:")
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showReminderSheet.toggle()
                        viewModel.saveReminder()
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
                        viewModel.resetVariables()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
    
    var dateForm: some View {
        Group {
            Toggle(isOn: $useDate.animation()) {
                Label(
                    title: {
                        VStack(alignment: .leading) {
                            Text("Date")
                            if useDate {
                                Text(viewModel.remindMeTime)
                                    .font(.caption)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }, icon: {
                        Image(systemName: "calendar")
                    }
                )
            }
            if useDate {
                DatePicker(
                    "",
                    selection: $viewModel.reminderDate,
                    in: Date()...
                )
                .datePickerStyle(.graphical)
                .symbolEffect(.bounce, value: useDate)
            }
        }
    }
}

#Preview {
    ReminderFormView(showReminderSheet: .constant(true),
                     viewModel: .init(
                        apiService: APINotificationClient(), reminder: Reminder.preview
                     )
    )
}
