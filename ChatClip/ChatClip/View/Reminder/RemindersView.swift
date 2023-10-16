//
//  ReminderView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import SwiftUI

struct RemindersView: View {
    
    // MARK: Properties
    
    @State private var showReminderSheet: Bool = false
    
    var viewModel: RemindersViewModel
    
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
                                .swipeActions(edge: .leading) {
                                    Button {
                                        viewModel.editReminder()
                                    } label: {
                                        Image(systemName: "pencil")
                                    }
                                }
                                .tint(.blue)
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
                        showReminderSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(Color.accent)
                            .frame(width: 40, height: 40)
                    }
                })
            }
            .sheet(isPresented: $showReminderSheet) {
                ReminderFormView(showReminderSheet: $showReminderSheet, viewModel: viewModel.reminderFormViewModel)
                    .presentationDetents([.large])
            }
            .onAppear {
                viewModel.onAppear()
            }
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
