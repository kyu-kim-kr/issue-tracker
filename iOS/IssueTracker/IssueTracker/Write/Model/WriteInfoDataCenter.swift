//
//  WriteInfoDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import Foundation

class WriteInfoDataCenter {
    enum Category {
        case label([Label])
        case milestone([Milestone])
        case assign([Assign])
        case none
    }
    var alamofireNetworkManager: AlamofireNetworkable
    var selectedLabelInfo: IssueFrame
    var selectLabel: Label?
    var selectMilestone: Milestone?
    var selectAssign: Assign?
    var labelList: [Label]
    var milestoneList: [Milestone]
    var assignList: [Assign]
    var reloadLabelsHandler: (() -> ())?
    
    var selectedCategory: Category
    
    init(reloadLabelsHandler: (() -> ())?) {
        self.labelList = [Label]()
        self.milestoneList = [Milestone]()
        self.assignList = [Assign]()
        self.selectedCategory = .none
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.selectedLabelInfo = IssueFrame(title: "", bodyDescription: "", assignee: 1, labelIDs: [Int](), milestoneID: 1)
        self.reloadLabelsHandler = reloadLabelsHandler
    }
    
    func saveTitle(_ title: String?) {
        self.selectedLabelInfo.title = title ?? ""
    }
    
    func saveBody(_ body: String) {
        self.selectedLabelInfo.bodyDescription = body
    }
    
    func appendBody(_ body: String) {
        self.selectedLabelInfo.bodyDescription += body
    }
    
    func convertImageMarkdown(url: String) -> String {
        return "\n![image](\(url))\n"
    }
    
    func appendImageMarkdown(url: String) {
        let imageMarkdown = convertImageMarkdown(url: url)
        self.selectedLabelInfo.bodyDescription += imageMarkdown
    }
    
    func selectedItemsCount() -> Int {
        switch selectedCategory {
        case .label(let labelList): return labelList.count
        case .milestone(let milestoneList): return milestoneList.count
        case .assign(let assignList): return assignList.count
        default: return 0
        }
    }
    
    func selectedItem(of index: Int) {
        switch selectedCategory {
        case .label(let labelList):
            selectedLabelInfo.labelIDs.append(labelList[index].id)
            selectLabel = labelList[index]
        case .milestone(let milestoneList):
            selectedLabelInfo.milestoneID = milestoneList[index].id
            selectMilestone = milestoneList[index]
        case .assign(let assignList):
            selectedLabelInfo.assignee = assignList[index].id
            selectAssign = assignList[index]
        default:
            break
        }
    }
    
    func makeIssue(completion: @escaping (() -> ())) {
        let body = self.selectedLabelInfo.dictionaryRepresentation
        self.alamofireNetworkManager.request(decodingType: StatusResponse.self,
                                             endPoint: .list,
                                             method: .post,
                                             parameters: body,
                                             headers: nil) { (result) in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func getImageAddress(imageData: Data, completion: @escaping ((String) -> ())) {
        self.alamofireNetworkManager.upload(imageData: imageData) { (result) in
            switch result {
            case .success(let imageURL):
                DispatchQueue.main.async {
                    completion(imageURL.imageURL)
                }
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func getAllCategory() {
        self.alamofireNetworkManager.request(decodingType: [Label].self,
                                             endPoint: .labels,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let labels):
                self.labelList = labels
            case .failure(let error):
                print(error.description)
            }
        }
        
        self.alamofireNetworkManager.request(decodingType: [Milestone].self,
                                             endPoint: .milestone,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let milestones):
                self.milestoneList = milestones
            case .failure(let error):
                print(error.description)
            }
        }
        
        self.alamofireNetworkManager.request(decodingType: [Assign].self,
                                             endPoint: .assignees,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let assigness):
                self.assignList = assigness
            case .failure(let error):
                print(error.description)
            }
        }
    }
}
