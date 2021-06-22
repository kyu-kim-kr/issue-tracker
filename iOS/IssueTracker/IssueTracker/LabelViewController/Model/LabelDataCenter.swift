//
//  LabelDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import Foundation

class LabelDataCenter {
    var alamofireNetworkManager: AlamofireNetworkManager
    var labelLoadHandler: (() -> ())?
    var labelList: [Label] {
        didSet {
            labelLoadHandler?()
        }
    }
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager()
        self.labelList = [Label]()
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
                NSLog(error.localizedDescription)
            }
        }
    }
    
    
}
