//
//  IssueDetailDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

class IssueDetailDataCenter {
    private(set) var issue: Issue
    private(set) var emojiData: [Emoji] {
        didSet {
            emojiReloadHandler?()
        }
    }
    private(set) var comments: [Comment] {
        didSet {
            reloadHandler?()
            print(issue)
            print(comments)
        }
    }
    private(set) var alamofireNetworkManager: AlamofireNetworkManager
    var reloadHandler: (() -> ())?
    var emojiReloadHandler: (() -> ())?
    
    init(issue: Issue) {
        self.issue = issue
        self.comments = [Comment]()
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.emojiData = [Emoji]()
        self.getComments()
        //MARK: - 이모지를 가져오는 network 추가 필요!!!!!!!!!!!!!!!!!!!!!!!!!
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
