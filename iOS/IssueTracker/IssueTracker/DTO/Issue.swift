//
//  IssueList.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import Foundation

struct Issue: Codable, Hashable {
    var id: Int
    var title: String
    var issueDescription: String
    var authorAvatarURL: String
    var labelList: [IssueLabel]
    var issueNumber: Int
    var createdTime: String
    var milestoneTitle: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case issueDescription = "description"
        case authorAvatarURL = "author_avatar_url"
        case labelList = "label_list"
        case issueNumber = "issue_number"
        case createdTime = "created_time"
        case milestoneTitle = "milestone_title"
    }
    
    static func == (lhs: Issue, rhs: Issue) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
