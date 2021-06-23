//
//  SessionModel.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation

struct SessionModel: Codable {
    static var shared = SessionModel()
    
    private(set) var jwt: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdmF0YXJfdXJsIjoiaHR0cHM6Ly9hdmF0YXJzLmdpdGh1YnVzZXJjb250ZW50LmNvbS91LzE2Njk0MzQ2P3Y9NCIsIm5hbWUiOiJNSmJhZSIsImlzcyI6Imlzc3VlLXRyYWNrZXIiLCJpZCI6MTY2OTQzNDZ9.fuyAnE21exNCg5piU3p-_-U67jqoQEUPtClfLCxkElU"
    
    private init() { }
    
    mutating func setJWT(_ jwt: String) {
        self.jwt = jwt
    }
}
