//
//  DateFormater.swift
//  MyHabits
//
//  Created by  Matvey on 12.03.2021.
//

import Foundation

struct DateConverter {
    static func dateToString(_ date: Date?) -> String {
        guard let date = date else { return "A long time ago" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateText = dateFormatter.string(from: date)
        return dateText
    }
}
