//
//  DetailBody.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/28.
//

import Foundation

struct DetailBody {
    var imageURL: String
    var userName: String
    var writeDate: Date
    var body: String
    var passingDate: String {
        return writeDate.passingDate
    }
}
