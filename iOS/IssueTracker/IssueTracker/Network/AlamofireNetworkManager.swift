//
//  Networkable.swift
//  IssueTracker
//
//  Created by Issac on 2021/07/02.
//

import Foundation
import Alamofire

protocol AlamofireNetworkable {
    func upload(imageData: Data, completionHandler: @escaping (Result<ImageURL, NetworkError>) -> ())
    func request<T: Decodable>(decodingType: T.Type, endPoint: ServerAPI.Endpoint,method: HTTPMethod, parameters: [String: Any]?,headers: HTTPHeaders?, isJSONEncoding: Bool , completionHandler: @escaping (Result<T, NetworkError>) -> Void)
}

extension AlamofireNetworkable {
    func request<T: Decodable>(decodingType: T.Type, endPoint: ServerAPI.Endpoint, method: HTTPMethod, parameters: [String: Any]? = nil, headers: HTTPHeaders? = nil, isJSONEncoding: Bool = true, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        request(decodingType: decodingType, endPoint: endPoint, method: method, parameters: parameters, headers: headers, isJSONEncoding: isJSONEncoding, completionHandler: completionHandler)
    }
}

final class AlamofireNetworkManager: AlamofireNetworkable {
    private let baseAddress: String
    private var baseHeaders: HTTPHeaders?
    
    init() {
        self.baseAddress = ServerAPI.baseURL
        self.baseHeaders = [
            "Authorization": "Barear \(SessionModel.shared.jwt)"
        ]
    }
    
    func upload(imageData: Data,
                completionHandler: @escaping (Result<ImageURL, NetworkError>) -> ()) {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(SessionModel.shared.jwt)",
            "Content-Type": "multipart/form-data"
        ]
        let url = baseAddress + ServerAPI.Endpoint.image.value
        AF.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "image", fileName: "image.png", mimeType: "image/png")
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
