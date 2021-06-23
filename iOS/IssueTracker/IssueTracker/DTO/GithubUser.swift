//
//  GithubUser.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/24.
//

import Foundation

struct GithubUser: Codable {
    var name: String
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case avatarURL = "avatar_url"
    }
}
