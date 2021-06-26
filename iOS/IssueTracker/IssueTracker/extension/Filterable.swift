//
//  Filterable.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/26.
//

import Foundation

protocol Filterable {
    var id: Int { get }
    var title: String { get }
    var isSelected: Bool? { get set }
    mutating func deselect()
}

extension Filterable {
    mutating func deselect() {
        self.isSelected = false
    }
}
