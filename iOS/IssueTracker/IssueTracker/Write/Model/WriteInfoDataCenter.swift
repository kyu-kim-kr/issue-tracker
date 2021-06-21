//
//  WriteInfoDataCenter.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import Foundation

class WriteInfoDataCenter {
    private(set) var title: String
    private(set) var body: String
    
    init() {
        self.title = ""
        self.body = ""
    }
    
    func saveTitle(_ title: String?) {
        self.title = title ?? ""
    }
    
    func saveBody(_ body: String) {
        self.body = body
    }
}
