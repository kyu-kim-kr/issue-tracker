//
//  IssueDetailLabel.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

struct IssueDetailLabel: Codable {
    var id: Int
    var labelTitle: String
    var colorCode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case labelTitle = "title"
        case colorCode = "color_code"
    }
}
