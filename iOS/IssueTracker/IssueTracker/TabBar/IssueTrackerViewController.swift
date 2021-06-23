//
//  IssueTrackerViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import UIKit

class IssueTrackerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTabBarItems()
    }
    
    func setTabBarItems() {
        self.tabBar.items?[0].image = UIImage(systemName: "exclamationmark.circle")
        self.tabBar.items?[0].title = "이슈"
        self.tabBar.items?[1].image = UIImage(systemName: "tag")
        self.tabBar.items?[1].title = "레이블"
        self.tabBar.items?[2].image = UIImage(systemName: "signpost.right")
        self.tabBar.items?[2].title = "마일스톤"
        ImageLoader.just(from: SessionModel.shared.user.avatarURL) { (image) in
            self.tabBar.items?[3].image = image?.resizedImage(newWidth: 27).roundedImage.withRenderingMode(.alwaysOriginal)
            self.tabBar.items?[3].title = "내 계정"
            self.tabBar.items?[3].imageInsets = UIEdgeInsets(top: 1, left: 1, bottom: 0, right: 1)
        }
    }
}

