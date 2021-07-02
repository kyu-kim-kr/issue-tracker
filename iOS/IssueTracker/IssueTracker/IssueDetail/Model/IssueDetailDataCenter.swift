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
    }
    
    var titleDescription: String {
        let beforeDate = issue.createdTime.passingDate
        return "\(beforeDate), \(issue.author.name)님이 작성했습니다."
    }
    
    func getEmoji() {
        let params = [
            "issue_id": issue.id,
            "user_id": issue.author.id
        ]
        alamofireNetworkManager.request(decodingType: [Emoji].self,
                                        endPoint: .emoji,
                                        method: .get,
                                        parameters: params,
                                        headers: nil,
                                        isJSONEncoding: false) { (result) in
            switch result {
            case .success(let emojis):
                self.emojiData = emojis
            case .failure(let error):
                NSLog(error.description)
            }
        }
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
                self.getEmoji()
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
}
