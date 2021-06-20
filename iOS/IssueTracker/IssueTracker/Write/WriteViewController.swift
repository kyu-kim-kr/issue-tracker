//
//  WriteViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/20.
//

import UIKit

class WriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    @IBAction func touchBarButton(_ sender: UIBarButtonItem) {
    }
}
