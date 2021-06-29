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
            case .deleteIssue(let id): return "\(Endpoint.list.value)/\(id)"
            case .closeIssue(let id): return "\(Endpoint.list.value)/\(id)"
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
    
    //MARK: - 임시로 imgur 호스팅 사용
    func upload(imageData: Data,
                completionHandler: @escaping (Result<ImageURL, NetworkError>) -> ()) {
        let header: HTTPHeaders = [
            "Authorization": "Client-ID 72dd369a025e6ed",
            "Content-Type": "multipart/form-data"
        ]
        let url = "https://api.imgur.com/3/image"
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "image")
        }, to: url, method: .post, headers: header).responseDecodable(of: ImageURL.self) { (response) in
            switch response.result {
            case .success(let imageURL):
                completionHandler(.success(imageURL))
            case .failure(_):
                completionHandler(.failure(.noResult))
            }
        }
    }
    
    
    func request<T: Decodable>(decodingType: T.Type,
                               endPoint: ServerAPI.Endpoint,
                               method: HTTPMethod,
                               parameters: [String: Any]? = nil,
                               headers: HTTPHeaders? = nil,
                               isJSONEncoding: Bool = true,
                               completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let address = baseAddress + endPoint.value
        let decoder = JSONDecoder()
        let encoding: ParameterEncoding = isJSONEncoding ? JSONEncoding.default : URLEncoding.default
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        AF.request(address,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: self.baseHeaders)
            .responseDecodable(of: decodingType, decoder: decoder) { dataResponse in
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
                    print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
                    return completionHandler(.failure(NetworkError.noResult))
                }
                print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
                completionHandler(.success(data))
            case 300..<400:
                completionHandler(.failure(NetworkError.noResult))
            case 400..<500:
                print(dataResponse.result)
                print(dataResponse.response)
                print(dataResponse.error)
                print(dataResponse.description)
//                print("data:  ", String(data: dataResponse.data!, encoding: .utf8))
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
