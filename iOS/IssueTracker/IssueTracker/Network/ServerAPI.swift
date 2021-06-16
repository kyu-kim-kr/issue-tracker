//
//  ServerAPI.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/07.
//

import Foundation
import Alamofire

struct ServerAPI {
    static var baseURL = "http://"
    static var scheme = "issue-tracker"
    
    enum Endpoint: String {
        case detail = "/detail"
        case github = "/api/login/auth"
        case list = "/api/issues"
        case labels = "/api/labels"
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
    private let baseHeaders: HTTPHeaders
    var scheme: String {
        return ServerAPI.scheme
    }
    
    init(baseAddress: String, baseHeaders: HTTPHeaders) {
        self.baseAddress = baseAddress
        self.baseHeaders = baseHeaders
    }
    
    convenience init(baseAddress: String) {
        let baseHeaders: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
        self.init(baseAddress: baseAddress, baseHeaders: baseHeaders)
    }
    
    func request<T: Decodable>(decodingType: T.Type,
                               endPoint: ServerAPI.Endpoint,
                               method: HTTPMethod,
                               parameters: [String: Any]?,
                               completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        let address = baseAddress + endPoint.rawValue
        print(address)
        AF.request(address,
                   method: method,
                   parameters: parameters,
                   encoding: URLEncoding.default,
                   headers: self.baseHeaders)
            .responseDecodable(of: decodingType) { dataResponse in
                
            guard let statusCode = dataResponse.response?.statusCode else {
                return completionHandler(.failure(NetworkError.internet))
            }
            switch statusCode {
            case 200..<300:
                guard let data = dataResponse.value else {
                    return completionHandler(.failure(NetworkError.noResult))
                }
                completionHandler(.success(data))
            case 300..<400:
                completionHandler(.failure(NetworkError.noResult))
            case 400..<500:
                completionHandler(.failure(NetworkError.notAllowed))
            case 500...:
                completionHandler(.failure(NetworkError.server))
            default:
                completionHandler(.failure(NetworkError.unknown))
            }
        }
    }
    
}

final class AlamofireImageLoadManager {
    private let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]

    func load(from imageUrl: String, completionHandler: @escaping (String) -> ()) {
        guard let fileName = URL(string: imageUrl)?.lastPathComponent else { return }
        
        if let cache = availableCache(of: fileName) {
            return completionHandler(cache)
        }
        
        let request = downloadRequest(of: imageUrl, fileName: fileName)
        request.responseURL { response in
            if response.error == nil, let filePath = response.fileURL?.path {
                completionHandler(filePath)
            }
        }
    }
    
    private func availableCache(of fileName: String) -> String? {
        let expectedPath = cacheURL.path + "/\(fileName)"
        return FileManager.default.fileExists(atPath: expectedPath) ? expectedPath : nil
    }
    
    private func downloadRequest(of imageURL: String, fileName: String) -> DownloadRequest {
        let destination: DownloadRequest.Destination = { _,_ in
            let fileURL = self.cacheURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        return AF.download(imageURL, to: destination)
    }
    
}
