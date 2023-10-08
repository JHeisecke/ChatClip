//
//  ReminderFormView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-29.
//

import SwiftUI

struct ReminderFormView: View {
    
    @Binding var showReminderSheet: Bool
    
    @State private var title: String = ""
    @State private var phoneNumber: String = ""
    @State private var message: String = ""
    
    @State private var useDate: Bool = false
    @State private var remindMeDate: Date = Date()
    
    @Bindable var viewModel: ReminderFormViewModel
    
    var body: some View {
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
                    dateForm
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
                        title = ""
                        phoneNumber = ""
                        message = ""
                        remindMeDate = Date()
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
            Toggle(isOn: $useDate) {
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
                    selection: $remindMeDate
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
                        apiService: APIClient(), reminder: Reminder.preview
                     )
    )
}
