//
//  LabelDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

class LabelDataCenter {
    var alamofireNetworkManager: AlamofireNetworkable
    var makedLabel: MakedLabel
    var labelLoadHandler: (() -> ())?
    var labelList: [Label] {
        didSet {
            labelLoadHandler?()
        }
    }
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.labelList = [Label]()
        self.makedLabel = MakedLabel(title: "", labelDescription: "", colorCode: "", textColor: "black")
    }
    
    func setLabelTitle(_ title: String) {
        self.makedLabel.title = title
    }
    
    func setLabelDescription(_ description: String) {
        self.makedLabel.labelDescription = description
    }
    
    func setHexCode(_ hex: String) {
        self.makedLabel.colorCode = hex
    }
    
    func deleteLocalLabel(index: Int) {
        self.labelList.remove(at: index)
    }
    
    func makeLabels(completion: @escaping (() -> ())) {
        self.alamofireNetworkManager.request(decodingType: StatusResponse.self,
                                             endPoint: .labels,
                                             method: .post,
                                             parameters: makedLabel.dictionaryRepresentation,
                                             headers: nil) { (result) in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
    
    func deleteLabel(index: Int, completion: @escaping (() -> ())) {
        let ID = self.labelList[index].id
        self.alamofireNetworkManager.request(decodingType: Deleted.self,
                                             endPoint: ServerAPI.Endpoint.deleteLabel(ID),
                                             method: .delete,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                NSLog(error.description)
                completion()
            }
        }
    }
    
    func getLabels() {
        self.alamofireNetworkManager.request(decodingType: [Label].self,
                                             endPoint: ServerAPI.Endpoint.labels,
                                             method: .get,
                                             parameters: nil,
                                             headers: nil) { (result) in
            switch result {
            case .success(let labels):
                self.labelList = labels
            case .failure(let error):
                NSLog(error.description)
            }
        }
    }
    
    
}
