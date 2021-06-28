//
//  IssueDetailDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

class IssueDetailDataCenter {
    private(set) var issue: Issue
    private(set) var comments: [Comment]
    
    init(issue: Issue) {
        self.issue = issue
        self.comments = [Comment]()
    }
    
    var titleDescription: String {
        let beforeDate = issue.createdTime.passingDate
        return "\(beforeDate), \(issue.author.name)님이 작성했습니다."
    }
}
