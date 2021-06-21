//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import Foundation
import OctoKit
import AuthenticationServices

class OAuthManager {
    let alamofireNetworkManager: AlamofireNetworkManager
    var errorHandler: ((String) -> ())?
    lazy var config = OAuthConfiguration.init(token: "34a66f51f68864c9adfd", //1f8b844e0951dd8b43cb, ios 5478b59babc40b37205d
                                              secret: "",
                                              scopes: ["user"])
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager(baseAddress: "http://3.35.48.70:8080")
    }
    
    func initPostLoginCodeWebAuthSession(completion: @escaping (GithubUser) -> ()) -> ASWebAuthenticationSession? {
        let scheme = alamofireNetworkManager.scheme
        guard let url = config.authenticate()?.appending([URLQueryItem(name: "redirect_uri", value: "\(scheme)://login")]) else { return nil }

        return ASWebAuthenticationSession.init(url: url, callbackURLScheme: scheme, completionHandler: { (callBack: URL?, error: Error?) in
            if error != nil {
                self.errorHandler?(NetworkError.oauthError.description)
                return
            }
            guard let successURL = callBack else { return }
            let callBackURLCode = successURL.extractCallbackURLCode()          
            self.alamofireNetworkManager.request(decodingType: GithubUser.self,
                                                 endPoint: .github,
                                                 method: .get,
                                                 parameters: ["client": "ios",
                                                              "code": callBackURLCode],
                                                 headers: ["code": callBackURLCode]) { (result) in
                switch result {
                case .success(let githubUser):
                    completion(githubUser)
                case .failure(let error):
                    print(error.description)
                    self.errorHandler?(error.description)
                }
            }
        })
    }
}
