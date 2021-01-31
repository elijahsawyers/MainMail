//
//  Date+String.swift
//  Main Mail
//
//  Created by Elijah Sawyers on 1/31/21.
//

import Foundation

extension Date {
    static func from(string: String) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        let timeZone = TimeZone(secondsFromGMT: 0)
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        return dateFormatter.date(from: string)
    }
}
