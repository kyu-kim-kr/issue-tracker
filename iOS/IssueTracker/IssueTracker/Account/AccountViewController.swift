//
//  AccountViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        self.name.text = "✨\(SessionModel.shared.user.name)✨"
        ImageLoader.just(from: SessionModel.shared.user.avatarURL) { (image) in
            self.profile.image = image?.roundedImage.withRenderingMode(.alwaysOriginal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.navigationItem.title = "계정"
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem()
        self.tabBarController?.navigationItem.searchController = nil
    }
    
    
}
