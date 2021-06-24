//
//  ImageURL.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/24.
//

import Foundation

struct ImageURL: Decodable {
    let link: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.link = try dataContainer.decode(String.self, forKey: .link)
    }
    
    enum CodingKeys: String, CodingKey {
        case data, link
    }
}
