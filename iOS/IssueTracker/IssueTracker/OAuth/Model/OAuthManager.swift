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
    lazy var config = OAuthConfiguration.init(token: ServerAPI.clientID,
                                              secret: "",
                                              scopes: ServerAPI.githubScopes)
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager()
    }
    
    func initPostLoginCodeWebAuthSession(completion: @escaping (GithubUser) -> ()) -> ASWebAuthenticationSession? {
        let scheme = ServerAPI.scheme
        guard let url = config.authenticate()?.appending([ServerAPI.githubAuthenticateURLQueryItem]) else { return nil }

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
                                                 headers: nil) { (result) in
                switch result {
                case .success(let githubUser):
                    completion(githubUser)
                case .failure(let error):
                    self.errorHandler?(error.description)
                }
            }
        })
    }
}
