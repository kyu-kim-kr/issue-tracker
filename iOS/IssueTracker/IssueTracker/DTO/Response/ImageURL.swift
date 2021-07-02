//
//  ImageURL.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/24.
//

import Foundation

struct ImageURL: Decodable {
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
    }
}
