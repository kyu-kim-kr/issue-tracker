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
    lazy var config = OAuthConfiguration.init(token: "5478b59babc40b37205d",
                                              secret: "",
                                              scopes: ["user"])
    
    init() {
        self.alamofireNetworkManager = AlamofireNetworkManager(baseAddress: "https://f88e009a-3e2b-4862-838e-1f2cde9b95ed.mock.pstmn.io")
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
                                                 parameters: ["code": callBackURLCode]) { (result) in
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
