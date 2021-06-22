//
//  IssueDetailMilestone.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

struct IssueDetailMilestone: Codable {
    var milestoneTitle: String
    var openedIssueCount: Int
    var closedIssueCount: Int
    
    enum CodingKeys: String, CodingKey {
        case milestoneTitle = "title"
        case openedIssueCount = "opened_issue_count"
        case closedIssueCount = "closed_issue_count"
    }
}
