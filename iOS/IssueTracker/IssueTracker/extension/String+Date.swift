//
//  String+Date.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/23.
//

import Foundation

extension String {
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: self)
    }
}
