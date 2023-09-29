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
    @State private var useTime: Bool = false
    @State private var title: String = ""
    @State private var phoneNumber: String = ""
    @State private var message: String = ""
    @State private var remindMeAt: Date = Date()
    
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

#Preview {
    ReminderFormView(showReminderSheet: .constant(true))
}
