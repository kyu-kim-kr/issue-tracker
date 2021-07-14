//
//  Comment.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/28.
//

import Foundation

struct Comment: Codable {
    var id: Int
    var commentDescription: String
    var createdTime: Date
    var author: Author
    
    enum CodingKeys: String, CodingKey {
        case id, author, createdTime
        case commentDescription = "description"
    }
}
