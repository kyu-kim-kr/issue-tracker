//
//  Author.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

class Author: Codable, Filterable {
    private(set) var id: Int
    private(set) var name: String
    private(set) var avatarURL: String
    var title: String {
        return name
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id = "user_id"
        case avatarURL = "avatar_url"
    }
}
