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
    @State private var showDatePicker: Bool = false
    @State private var useTime: Bool = false
    @State private var remindMeDate: Date = Date()
    @State private var remindMeTime: Date = Date()
    
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
                    //timeForm
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
            Toggle(isOn: $useDate.animation()) {
                Label(
                    title: {
                        VStack(alignment: .leading) {
                            Text("Date")
                            if useDate {
                                Text("Today")
                                    .font(.caption)
                            }
                        }
                    }, icon: {
                        Image(systemName: "calendar")
                    }
                )
            }
            if showDatePicker {
                DatePicker(
                    "",
                    selection: $remindMeDate,
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .symbolEffect(.bounce, value: useDate)
            }
        }
    }
    
    var timeForm: some View {
        Group {
            Toggle(isOn: $useTime.animation()) {
                Label(
                    title: {
                        VStack(alignment: .leading) {
                            Text("Time")
                            if useTime {
                                Text("Today")
                                    .font(.caption)
                            }
                        }
                    }, icon: {
                        Image(systemName: "clock")
                    }
                )
            }            
            if useTime {
                DatePicker(
                    "",
                    selection: $remindMeTime,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .symbolEffect(.bounce, value: useTime)
            }
        }
        .onChange(of: useTime) { _, newValue in
            if newValue {
                useDate = newValue
            }
        }
    }
}

#Preview {
    ReminderFormView(showReminderSheet: .constant(true))
}
