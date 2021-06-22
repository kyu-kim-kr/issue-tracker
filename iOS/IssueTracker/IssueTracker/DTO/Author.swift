//
//  Author.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

struct Author: Codable {
    var id: Int
    var name: String
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "user_id"
        case avatarURL = "avatar_url"
    }
}
