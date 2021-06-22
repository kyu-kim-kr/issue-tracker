//
//  MakerdMilestone.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/23.
//

import Foundation

struct MakedMilestone: Codable {
    var title: String
    var milestoneDescription: String
    var due: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case milestoneDescription = "description"
        case due = "due_date"
    }
    
    var dictionaryRepresentation: [String: Any] {
            return [
                "title": title,
                "description": milestoneDescription,
                "due_date": due,
            ]
        }
}
