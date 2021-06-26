//
//  FilterStatus.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import Foundation

class FilterStatusDataCenter: NSObject {
    enum Section: String, CaseIterable {
        case status = "상태"
        case author = "작성자"
        case label = "레이블"
        case milestone = "마일스톤"
    }
}
