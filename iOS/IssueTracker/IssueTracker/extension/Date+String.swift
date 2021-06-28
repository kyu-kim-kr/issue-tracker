//
//  Date+String.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/28.
//

import Foundation

extension Date {
    var passingDate: String {
        var beforeDate = ""
        let subDate = Int(Date().timeIntervalSince1970 - self.timeIntervalSince1970)
        if subDate < 60 {
            beforeDate = "\(subDate)초 전"
        } else if subDate / 60 < 60 {
            beforeDate = "\(subDate / 60)분 전"
        } else if subDate / 3600 < 24 {
            beforeDate = "\(subDate / 3600)시간 전"
        } else {
            beforeDate = "\(subDate / 86400)일 전"
        }
        return beforeDate
    }
}
