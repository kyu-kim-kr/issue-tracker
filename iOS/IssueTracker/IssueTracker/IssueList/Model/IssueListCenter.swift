//
//  IssueListCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

class IssueListCenter {
    enum StatusDescription: CustomStringConvertible {
        case completeDelete
        case failDelete
        case completeClose
        case failClose
        
        var description: String {
            switch self {
            case .completeDelete:
                return "이슈 삭제가 완료됐습니다"
            case .failDelete:
                return "이슈 삭제가 완료되지 않았습니다"
            case .completeClose:
                return "이슈 close가 완료됐습니다"
            case .failClose:
                return "이슈 close가 완료되지 않았습니다"
            }
        }
    }
    
    
    let alamofireNetworkManager: AlamofireNetworkManager
    var listLoadHandler: (([Issue]) -> ())?
    var networkCompleteHandler: ((String) -> ())?
    var issueList: [Issue] {
        didSet {
            listLoadHandler?(issueList)
        }
    }
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.issueList = [Issue]()
    }
    
    func deleteIssue(index: Int) {
        self.issueList.remove(at: index)
    }
    
    func getIssueList() {
        self.alamofireNetworkManager
            .request(decodingType: [Issue].self,
                     endPoint: ServerAPI.Endpoint.list,
                     method: .get,
                     parameters: nil,
                     headers: nil) { (result) in
                switch result {
                case .success(let issues):
                    self.issueList = issues
                case .failure(let error):
                    NSLog(error.description)
                }
        }
    }
    
    func requestDeleteIssue(index: Int) {
        let issueID = self.issueList[index].id
        let body: [String: Any] = ["deleted": true]
        self.alamofireNetworkManager
            .request(decodingType: StatusResponse.self,
                     endPoint: .deleteIssue(issueID),
                     method: .patch,
                     parameters: body,
                     headers: nil) { [weak self] (result) in
                switch result {
                case .success(_):
                    self?.networkCompleteHandler?(StatusDescription.completeDelete.description)
                case .failure(let error):
                    self?.networkCompleteHandler?("\(StatusDescription.failDelete.description) \(error.description)")
                }
            }
    }
    
    func requestCloseIssue(index: Int) {
        let issueID = self.issueList[index].id
        let body: [String: Any] = ["closed": true]
        self.alamofireNetworkManager
            .request(decodingType: StatusResponse.self,
                     endPoint: .deleteIssue(issueID),
                     method: .patch,
                     parameters: body,
                     headers: nil) { [weak self] (result) in
                switch result {
                case .success(_):
                    self?.networkCompleteHandler?(StatusDescription.completeClose.description)
                case .failure(let error):
                    self?.networkCompleteHandler?("\(StatusDescription.failClose.description) \(error.description)")
                }
            }
    }
}
