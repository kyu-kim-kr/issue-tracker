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
import Lottie

class OAuthViewController: UIViewController {
    var webAuthSession: ASWebAuthenticationSession?
    var oauthManager: OAuthManager!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var lotiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - 네트워크가 안될 때
//        guard let vc = self.storyboard?.instantiateViewController(identifier: IssueTrackerViewController.className) as? IssueTrackerViewController else { return }
//        self.navigationController?.pushViewController(vc, animated: true)
        
        self.oauthManager = OAuthManager()
        self.setAppleSignInButton()
        self.makeAnimationView()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.configOAuth()
    }
    
    private func bind() {
        self.oauthManager.errorHandler = { error in
            print(error)
        }
    }
    
    private func makeAnimationView() {
        let animationView = AnimationView(name: "danceAlert")
        lotiView.addSubview(animationView)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.topAnchor.constraint(equalTo: lotiView.topAnchor).isActive = true
        animationView.bottomAnchor.constraint(equalTo: lotiView.bottomAnchor).isActive = true
        animationView.rightAnchor.constraint(equalTo: lotiView.rightAnchor).isActive = true
        animationView.leftAnchor.constraint(equalTo: lotiView.leftAnchor).isActive = true
    }
    
    func configOAuth() {
        webAuthSession = self.oauthManager.initPostLoginCodeWebAuthSession() { (githubUser) in
            DispatchQueue.main.async {
                SessionModel.shared.setJWT(githubUser.jwt)
                guard let vc = self.storyboard?.instantiateViewController(identifier: IssueTrackerViewController.className) as? IssueTrackerViewController else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        webAuthSession?.presentationContextProvider = self
    }
    
    func setAppleSignInButton() {
        let authorizationButton = ASAuthorizationAppleIDButton(type: .signIn, style: .whiteOutline)
        authorizationButton.addTarget(self, action: #selector(appleSignInButtonPress(_:)), for: .touchUpInside)
        self.buttonStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc func appleSignInButtonPress(_ sender: ASAuthorizationAppleIDButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return self.view.window ?? ASPresentationAnchor()
    }
    
    @IBAction func loginWithGithub(_ sender: Any) {
        webAuthSession?.start()
    }
}

extension OAuthViewController: ASWebAuthenticationPresentationContextProviding { }


extension OAuthViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension OAuthViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("User ID : \(userIdentifier)")
            print("User Email : \(email ?? "")")
            print("User Name : \((fullName?.givenName ?? "") + (fullName?.familyName ?? ""))")
            
            guard let vc = self.storyboard?.instantiateViewController(identifier: IssueTrackerViewController.className) as? IssueTrackerViewController else { return }
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("에러~!?")
    }
}
