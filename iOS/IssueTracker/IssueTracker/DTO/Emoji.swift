//
//  Emoji.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/30.
//

import Foundation

struct Emoji: Codable {
    var code: String
    var selected: Bool
    var emoji: String {
        switch code {
        case ":thumbs_up:": return "👍"
        case ":heart_eyes:": return "😍"
        default: return ""
        }
    }
}
