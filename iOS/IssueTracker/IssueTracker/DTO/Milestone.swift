//
//  Milestone.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import Foundation

struct Milestone: Codable {
    var id: Int
    var title: String
    var milestoneDescription: String
    var due: String
    var opendIssueCount: Int
    var closedIssueCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case milestoneDescription = "description"
        case due = "due_date"
        case opendIssueCount = "opened_issue_count"
        case closedIssueCount = "closed_issue_count"
    }
}
