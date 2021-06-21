//
//  CategoryDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import Foundation

class CategoryDataCenter {
    enum Category {
        case label([Label])
        case milestone([Milestone])
        case assign([Assign])
        case none
    }
    var selectedLabelInfo: IssueFrame
    var selectLabel: Label?
    var selectMilestone: Milestone?
    var selectAssign: Assign?
    var labelList: [Label]
    var milestoneList: [Milestone]
    var assignList: [Assign]
    
    var selectedCategory: Category
    
    init() {
        self.labelList = [Label]()
        self.milestoneList = [Milestone]()
        self.assignList = [Assign]()
        self.selectedCategory = .none
        self.selectedLabelInfo = IssueFrame(title: "", bodyDescription: "", assignee: 1, labelIDs: [1], milestoneID: 1)
        
        //MARK: - dummy
        self.labelList = [Label(id: 1, title: "jhop", labelDescription: "asdfasdf", colorCode: "asdf", isWhiteFontColor: true)]
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
    
}
