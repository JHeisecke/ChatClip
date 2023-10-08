//
//  Reminder.swift
//  ChatClip
//
//  Created by Javier Heisecke on 2023-09-28.
//

import Foundation

typealias RemindersList = [Reminder]

struct Reminder: Identifiable, Codable {
    var id: Int
    var number: String
    var title: String?
    var time: Date?
    var message: String?
}

extension Reminder {
    
    static var preview: Reminder {
        previews[1]
    }
    
    static var previews: RemindersList {
        [
            Reminder(id: 0, number: "+59598345948"),
            Reminder(id: 1, number: "+59598345948", title: "Text Mr. Rogers"),
            Reminder(id: 2, number: "+59598345948", title: "Text my Mom", time: Date().addingTimeInterval(1000)),
            Reminder(id: 3, number: "+59598345948", title: "Ask my friend for my bike", time: Date().addingTimeInterval(4000), message: "Hey bro! You've got my bike for a while, please give it back, don't be na ass"),
            Reminder(id: 4, number: "+59598345948", title: "Text Mr. Rogers", message: "Hey bro! You've got my bike for a while, please give it back, don't be na ass"),
        ]
    }
}
