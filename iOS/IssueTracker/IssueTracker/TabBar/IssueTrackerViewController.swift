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
        self.tabBar.items?[3].image = UIImage(systemName: "person")
        self.tabBar.items?[3].title = "내 계정"
    }
}
