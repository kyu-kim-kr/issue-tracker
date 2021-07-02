//
//  MilestoneDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

//MARK: - 해야함
class MilestoneDataCenter {
    var alamofireNetworkManager: AlamofireNetworkable
    var makedMilestone: MakedMilestone
    var milestoneLoadHandler: (() -> ())?
    var milestoneList: [Milestone] {
        didSet {
            milestoneLoadHandler?()
        }
    }
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.milestoneList = [Milestone]()
        self.makedMilestone = MakedMilestone(title: "", milestoneDescription: "", due: "")
    }
    
    func setMilestoneTitle(_ title: String) {
        self.makedMilestone.title = title
    }
    
    func setMilestoneDescription(_ description: String) {
        self.makedMilestone.milestoneDescription = description
    }
    
    func setDate(_ due: String) {
        self.makedMilestone.due = due
    }
    
    func deleteLocalMilestone(index: Int) {
        self.milestoneList.remove(at: index)
    }
    
    func makeMilestone(completion: @escaping (() -> ())) {
        self.alamofireNetworkManager.request(decodingType: StatusResponse.self,
                                             endPoint: .milestone,
                                             method: .post,
                                             parameters: makedMilestone.dictionaryRepresentation,
                                             headers: nil) { (result) in
            switch result {
            case .success(_):
                print("성공")
                completion()
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
    
    func deleteMilestone(index: Int, completion: @escaping (() -> ())) {
        let ID = self.milestoneList[index].id
        self.alamofireNetworkManager.request(decodingType: Deleted.self,
                                             endPoint: ServerAPI.Endpoint.deleteMilestone(ID),
                                             method: .delete,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(_):
                print("삭제 성공")
                completion()
            case .failure(let error):
                NSLog(error.description)
                completion()
            }
        }
    }
    
    func getMilestones() {
        self.alamofireNetworkManager.request(decodingType: [Milestone].self,
                                             endPoint: ServerAPI.Endpoint.milestone,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let milestones):
                self.milestoneList = milestones
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
    
    
}
