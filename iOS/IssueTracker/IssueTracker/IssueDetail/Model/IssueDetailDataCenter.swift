//
//  IssueDetailDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

class IssueDetailDataCenter {
    private(set) var issue: Issue
    private(set) var comments: [Comment] {
        didSet {
            reloadHandler?()
            print(issue)
            print(comments)
        }
    }
    private(set) var alamofireNetworkManager: AlamofireNetworkManager
    var reloadHandler: (() -> ())?
    
    init(issue: Issue) {
        self.issue = issue
        self.comments = [Comment]()
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.getComments()
    }
    
    var titleDescription: String {
        let beforeDate = issue.createdTime.passingDate
        return "\(beforeDate), \(issue.author.name)님이 작성했습니다."
    }
    
    func getComments() {
        alamofireNetworkManager.request(decodingType: [Comment].self,
                                        endPoint: .comments(issue.id),
                                        method: .get,
                                        parameters: nil,
                                        headers: nil) { (result) in
            switch result {
            case .success(let comments):
                self.comments = comments
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
}
