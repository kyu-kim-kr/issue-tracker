//
//  MakedLabel.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/23.
//

import Foundation

struct MakedLabel: Codable {
    var title: String
    var labelDescription: String
    var colorCode: String
    var textColor: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case labelDescription = "description"
        case colorCode = "color_code"
        case textColor = "text_color"
    }
    
    var dictionaryRepresentation: [String: Any] {
            return [
                "title": title,
                "description": labelDescription,
                "color_code": colorCode,
                "text_color": textColor
            ]
        }
}
