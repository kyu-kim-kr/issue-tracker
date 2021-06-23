//
//  ServerAPI.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/07.
//

import Foundation
import Alamofire

protocol Networkable {
    func request<T: Decodable>(decodingType: T.Type,
                               endPoint: ServerAPI.Endpoint,
                               method: HTTPMethod,
                               parameters: [String: Any]?,
                               completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

struct ServerAPI {
    static var baseURL = "http://3.35.48.70:8080"
//    static var baseURL = "http://15.164.68.136"
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
            case .deleteIssue(let id): return "\(Endpoint.list.value)/\(id)"
            case .closeIssue(let id): return "\(Endpoint.list.value)/\(id)" //MARK: - 이상함
            case .deleteLabel(let id): return "\(Endpoint.labels.value)/\(id)"
            case .deleteMilestone(let id): return "\(Endpoint.milestone.value)/\(id)"
            }
        }
    
    }
}

enum NetworkError: Error {
    case internet
    case noResult
    case notAllowed
    case server
    case unknown
    case oauthError
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .internet:
            return "인터넷 연결을 확인해주세요"
        case .noResult:
            return "검색 결과를 찾을 수 없습니다"
        case .notAllowed:
            return "잘못된 접근입니다"
        case .server:
            return "서버 상태가 불안정합니다"
        case .unknown:
            return "알 수 없는 문제가 발생했습니다"
        case .oauthError:
            return "오오쓰 인증 과정에서 문제가 생겼습니다"
        }
    }
}


final class AlamofireNetworkManager {
    private let baseAddress: String
    private var baseHeaders: HTTPHeaders?
    
    init() {
        self.baseAddress = ServerAPI.baseURL
        self.baseHeaders = [
            "Authorization": "Barear \(SessionModel.shared.jwt)"
        ]
    }
    
    
    func request<T: Decodable>(decodingType: T.Type,
                               endPoint: ServerAPI.Endpoint,
                               method: HTTPMethod,
                               parameters: [String: Any]?,
                               headers: HTTPHeaders?,
                               isOAuth: Bool = false,
                               completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let address = baseAddress + endPoint.value
        let encoding: ParameterEncoding = isOAuth ? URLEncoding.default : JSONEncoding.default
        AF.request(address,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: self.baseHeaders)
            .responseDecodable(of: decodingType) { dataResponse in
                print(address, parameters, headers, self.baseHeaders)
                guard let statusCode = dataResponse.response?.statusCode else {
                    print(dataResponse.result)
                    print(dataResponse.response)
                    print(dataResponse.error)
                    print(dataResponse.description)
//                    print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
                    return completionHandler(.failure(NetworkError.internet))
            }
            switch statusCode {
            case 200..<300:
                guard let data = dataResponse.value else {
                    print(dataResponse.result)
                    print(dataResponse.response)
                    print(dataResponse.error)
                    print(dataResponse.description)
//                    print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
                    return completionHandler(.failure(NetworkError.noResult))
                }
                completionHandler(.success(data))
            case 300..<400:
                completionHandler(.failure(NetworkError.noResult))
            case 400..<500:
                print(dataResponse.result)
                print(dataResponse.response)
                print(dataResponse.error)
                print(dataResponse.description)
                print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
                completionHandler(.failure(NetworkError.notAllowed))
            case 500...:
                print(dataResponse.result)
                print(dataResponse.response)
                print(dataResponse.error)
                print(dataResponse.description)
                print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
                completionHandler(.failure(NetworkError.server))
            default:
                completionHandler(.failure(NetworkError.unknown))
            }
        }
    }
    
}
