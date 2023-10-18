//
//  ReminderView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct RemindersView: View {
    
    // MARK: Properties
    
    @Bindable var viewModel: RemindersViewModel
    
    @State var showReminderSheet = false
    @State var showGrantPermissionsAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .empty(let message):
                    Spacer()
                    Text(message)
                    Spacer()
                case .data(let reminderCellViewModels):
                    List {
                        ForEach(reminderCellViewModels) { cellViewModel in
                            ReminderCellView(viewModel: cellViewModel)
                            //TODO: Add Editing of reminders
                            //        .swipeActions(edge: .leading) {
                            //            Button {
                            //                viewModel.editReminder()
                            //            } label: {
                            //                Image(systemName: "pencil")
                            //            }
                            //        }
                            //        .tint(.blue)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        viewModel.deleteReminder(cellViewModel.reminder)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                                .tint(.red)
                                .listRowBackground(Color.secondaryBackground)
                        }
                    }
                    .listRowSpacing(20)
                    .scrollContentBackground(.hidden)
                    .background(Color.secondaryAccentColor)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button {
                        viewModel.checkNotificationsPermissions() { isGranted in
                            if isGranted {
                                showReminderSheet = true
                            } else {
                                showGrantPermissionsAlert = true
                            }
                            
                        }
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(Color.accent)
                            .frame(width: 40, height: 40)
                    }
                })
            }
            .sheet(isPresented: $showReminderSheet) {
                ReminderFormView(
                    showReminderSheet: $showReminderSheet,
                    viewModel: viewModel.reminderFormViewModel
                )
                .presentationDetents([.large])
            }
            .alert(
                String(localized: "ChatClip Would like to Send you Notifications"),
                isPresented: $showGrantPermissionsAlert,
                actions: {
                    Button("Cancel") {
                        showGrantPermissionsAlert.toggle()
                    }
                    Button("Settings") {
                        viewModel.goToSettings()
                    }
                }, message: {
                    Text("Go to Settings and allow ChatClip to send you notifications")
                }
            )
        }
    }
}

// MARK: - Preview

#Preview {
    TabView {
        RemindersView(
            viewModel: RemindersViewModel(
                store: PreviewsStore(),
                notificationService: APINotificationClient()
            )
        )
    }
}
