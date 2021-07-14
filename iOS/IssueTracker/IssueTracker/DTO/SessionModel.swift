//
//  SessionModel.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import Foundation
import JWTDecode

struct SessionModel: Codable {
    static var shared = SessionModel()
    private(set) var user: GithubUser = GithubUser(name: "", avatarURL: "")
    private(set) var jwt: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdmF0YXJfdXJsIjoiaHR0cHM6Ly9hdmF0YXJzLmdpdGh1YnVzZXJjb250ZW50LmNvbS91LzE2Njk0MzQ2P3Y9NCIsIm5hbWUiOiJNSmJhZSIsImlzcyI6Imlzc3VlLXRyYWNrZXIiLCJpZCI6MTY2OTQzNDZ9.fuyAnE21exNCg5piU3p-_-U67jqoQEUPtClfLCxkElU" {
        didSet {
            do {
                try self.decodeJWT()
            } catch {
                NSLog("decode JWT error")
            }
        }
    }
    
    private init() { }
    
    mutating func setJWT(_ jwt: String) {
        self.jwt = jwt
    }
    
    mutating func decodeJWT() throws {
        let payload = try decode(jwt: self.jwt)
        let data = try JSONSerialization.data(withJSONObject: payload.body)
        self.user = try JSONDecoder().decode(GithubUser.self, from: data)
    }
}
