//
//  IssueFrame.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import Foundation

struct IssueFrame: Codable {
    var title: String
    var bodyDescription: String
    var assignee: Int
    var labelIDs: [Int]
    var milestoneID: Int
    
    enum CodingKeys: String, CodingKey {
        case title, assignee
        case bodyDescription = "description"
        case labelIDs = "label_ids"
        case milestoneID = "milestone_id"
    }
}
