//
//  AccountViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
