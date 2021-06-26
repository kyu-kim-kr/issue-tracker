//
//  Label.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

struct Label: Codable, Filterable {
    private(set) var id: Int
    private(set) var title: String
    private(set) var labelDescription: String
    private(set) var colorCode: String
    private(set) var isWhiteFontColor: Bool
    var isSelected: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case labelDescription = "description"
        case colorCode = "color_code"
        case isWhiteFontColor = "font_light"
    }
}
