//
//  Label.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

struct Label: Codable {
    var id: Int
    var title: String
    var labelDescription: String
    var colorCode: String
    var textColor: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case labelDescription = "description"
        case colorCode = "color_code"
        case textColor = "text_color"
    }
}
