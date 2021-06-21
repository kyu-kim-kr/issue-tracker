//
//  IssueListCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

class IssueListCenter {
    let alamofireNetworkManager: AlamofireNetworkManager
    var listLoadHandler: (([Issue]) -> ())?
    var issueList: [Issue] {
        didSet {
            listLoadHandler?(issueList)
        }
    }
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager(baseAddress: "https://f88e009a-3e2b-4862-838e-1f2cde9b95ed.mock.pstmn.io")
        self.issueList = [Issue]()
    }
    
    func deleteIssue(index: Int) {
        self.issueList.remove(at: index)
    }
    
    func getIssueList() {
        self.alamofireNetworkManager.request(decodingType: [Issue].self,
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
}
