//
//  FilterStatus.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import Foundation

class FilterStatusDataCenter: NSObject {
    enum Section: String, CaseIterable, CustomStringConvertible {
        case author
        case label
        case milestone
        
        init?(index: Int) {
            switch index {
            case 0: self = .author
            case 1: self = .label
            case 2: self = .milestone
            default: return nil
            }
        }
        
        var description: String {
            switch self {
            case .author: return "작성자"
            case .label: return "레이블"
            case .milestone: return "마일스톤"
            }
        }
    }
    var alamofireNetworkManager: AlamofireNetworkManager
    var authorList: [Author]
    var labelList: [Label]
    var milestoneList: [Milestone]
    var categoryItems: [[Filterable]] {
        return [authorList, labelList, milestoneList]
    }
    
    override init() {
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.authorList = [Author]()
        self.labelList = [Label]()
        self.milestoneList = [Milestone]()
        super.init()
    }
    
    func getCategory(completion: @escaping (() -> ())) {
        self.getLabels(completion: completion)
        self.getAuthor(completion: completion)
        self.getMilestone(completion: completion)
    }
    
    func getLabels(completion: @escaping (() -> ())) {
        self.alamofireNetworkManager.request(decodingType: [Label].self,
                                             endPoint: ServerAPI.Endpoint.labels,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let labels):
                self.labelList = labels
                completion()
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
    
    func getAuthor(completion: @escaping (() -> ())) {
        self.alamofireNetworkManager.request(decodingType: [Author].self,
                                             endPoint: ServerAPI.Endpoint.assignees,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let authors):
                self.authorList = authors
                completion()
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
    
    func getMilestone(completion: @escaping (() -> ())) {
        self.alamofireNetworkManager.request(decodingType: [Milestone].self,
                                             endPoint: ServerAPI.Endpoint.milestone,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let milestones):
                self.milestoneList = milestones
                completion()
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
}
