//
//  IssueDetailDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

class IssueDetailDataCenter {
    private(set) var issue: Issue
    
    init(issue: Issue) {
        self.issue = issue
    }
    
    var titleDescription: String {
        
//        let beforeDate = makeBeforeDate(createdDate: <#T##Date#>)
        return ""
    }
    
    private func makeBeforeDate(createdDate: Date) -> String {
        var beforeDate = ""
        let subDate = Int(Date().timeIntervalSince1970 - createdDate.timeIntervalSince1970)
        if subDate < 60 {
            beforeDate = "\(subDate)초 전"
        } else if subDate / 60 < 60 {
            beforeDate = "\(subDate / 60)분 전"
        } else if subDate / 3600 < 24 {
            beforeDate = "\(subDate / 3600)시간 전"
        } else {
            beforeDate = "\(subDate / 86400)일 전"
        }
        return beforeDate
    }
}
