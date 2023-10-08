//
//  ReminderCellView.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-10-06.
//

import SwiftUI

struct ReminderCellView: View {
    
    var viewModel: ReminderCellViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if let title = viewModel.reminderTitle {
                Text(title)
                    .font(.glacial(.bold, size: 17))
                    .lineLimit(1)
            }
            Text(viewModel.reminderRecipient)
                .font(.glacial(.regular, size: 16))
            if let time = viewModel.reminderTime {
                HStack {
                    Image(systemName: "alarm")
                    Text("8:15 AM")
                        .font(.glacial(.regular, size: 15))
                }
            }
            if let message = viewModel.reminderMessage {
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

#Preview {
    List {
        ReminderCellView(viewModel: ReminderCellViewModel(reminder: Reminder.preview))
    }
}
