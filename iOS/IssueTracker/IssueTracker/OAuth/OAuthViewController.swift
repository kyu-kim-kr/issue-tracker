//
//  ViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/07.
//

import Foundation
import UIKit
import OctoKit
import AuthenticationServices

class OAuthViewController: UIViewController, ASWebAuthenticationPresentationContextProviding {
    var webAuthSession: ASWebAuthenticationSession?
    var oauthManager: OAuthManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.oauthManager = OAuthManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configOAuth()
    }
    
    func configOAuth() {
        webAuthSession = self.oauthManager.initPostLoginCodeWebAuthSession() { (userDTO) in
            DispatchQueue.main.async {
                guard let vc = self.storyboard?.instantiateViewController(identifier: IssueListViewController.className) as? IssueListViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        webAuthSession?.presentationContextProvider = self
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
    
    @IBAction func loginWithGithub(_ sender: Any) {
        webAuthSession?.start()
    }
}
