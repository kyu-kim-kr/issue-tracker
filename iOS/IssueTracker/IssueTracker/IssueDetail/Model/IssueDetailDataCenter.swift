//
//  IssueDetailDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

class IssueDetailDataCenter {
    var issueDetail: IssueDetail
    
    init() {
        //MARK: - dummy
        self.issueDetail = IssueDetail(issueDetailTitle: "이것은 디테일 타이틀입니다", issueDescription: "이것은 설명입니다 ~~헬로우~~", assignee: 1, createdTime: "2021-06-13", closed: false, milestone: IssueDetailMilestone(milestoneTitle: "마일스톤 제목", openedIssueCount: 3, closedIssueCount: 2), authorUserID: 1, issueNumber: 2, labelList: [IssueDetailLabel(id: 1, labelTitle: "라벨타이틀 입니다", colorCode: "#AAAAAA")])
    }
}
