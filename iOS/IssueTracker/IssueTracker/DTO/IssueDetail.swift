//
//  IssueDetail.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

struct IssueDetail: Codable {
    var issueDetailTitle: String
    var issueDescription: String
    var assignee: Int
    var createdTime: String
    var closed: Bool
    var milestone: IssueDetailMilestone
    var authorUserID: Int
    var issueNumber: Int
    var labelList: [IssueDetailLabel]
    
    enum CodingKeys: String, CodingKey {
        case assignee, closed, milestone
        case issueDetailTitle = "title"
        case issueDescription = "description"
        case createdTime = "created_time"
        case authorUserID = "author_user_id"
        case issueNumber = "issue_number"
        case labelList = "label_list"
    }
}
