//
//  IssueLabel.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import Foundation

struct IssueLabel: Codable {
    var id: Int
    var title: String
    var hex: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case hex = "color_code"
    }
}
