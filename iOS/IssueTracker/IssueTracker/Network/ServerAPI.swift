//
//  ServerAPI.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/07.
//

import Foundation
import Alamofire

struct ServerAPI {
    static var baseURL = "http://kyupig.com"
    static var redirectURLKey = "redirect_url"
    static var redirectURLValue = "\(scheme)://login"
    static var scheme = "issue-tracker"
    static var clientID = "34a66f51f68864c9adfd"
    static var githubScopes = ["user"]
    static var githubAuthenticateURLQueryItem = URLQueryItem(name: ServerAPI.redirectURLKey, value: ServerAPI.redirectURLValue)
    
    enum Endpoint {
        case detail
        case github
        case list
        case labels
        case milestone
        case assignees
        case image
        case emoji
        case comments(Int)
        case deleteIssue(Int)
        case closeIssue(Int)
        case deleteLabel(Int)
        case deleteMilestone(Int)
        
        var value: String {
            switch self {
            case .detail: return "/detail"
            case .github: return "/api/login/auth"
            case .list: return "/api/issues"
            case .labels: return "/api/labels"
            case .milestone: return "/api/milestones"
            case .assignees: return "/api/assignees"
            case .image: return "/api/images"
            case .comments(let id): return "\(Endpoint.list.value)/\(id)/comments"
            case .emoji: return "/api/emojis"
            case .deleteIssue(let id): return "\(Endpoint.list.value)/\(id)"
            case .closeIssue(let id): return "\(Endpoint.list.value)/\(id)"
            case .deleteLabel(let id): return "\(Endpoint.labels.value)/\(id)"
            case .deleteMilestone(let id): return "\(Endpoint.milestone.value)/\(id)"
            }
        }
    
    }
}
