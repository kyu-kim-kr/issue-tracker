//
//  SelectedStatus.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/26.
//

import Foundation

struct SelectedStatus {
    var id: Int
    var category: String
    var isSelected: Bool
    var parameter: [String: Any] {
        return [category: id]
    }
}
