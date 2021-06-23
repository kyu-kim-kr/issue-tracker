//
//  DateFormatter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/23.
//

import Foundation

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_KR")
        return formatter
    }()
}
