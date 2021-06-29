//
//  Milestone.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import Foundation

struct Milestone: Codable, Filterable {
    private(set) var id: Int
    private(set) var title: String
    private(set) var milestoneDescription: String
    private(set) var due: String?
    private(set) var opendIssueCount: Int
    private(set) var closedIssueCount: Int
    var displayOpenCount: String {
        return "열린 이슈 \(opendIssueCount)게"
    }
    var displayCloseCount: String {
        return "닫힌 이슈 \(closedIssueCount)게"
    }
    var issueProgress: String {
        let divide = floor(Double(closedIssueCount) / Double(opendIssueCount + closedIssueCount) * 100)
        let persent = divide.isNaN ? 0 : Int(divide)
        return "\(persent)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case milestoneDescription = "description"
        case due = "due_date"
        case opendIssueCount = "opened_issue_count"
        case closedIssueCount = "closed_issue_count"
    }
}
