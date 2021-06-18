//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit

class IssueDetailViewController: UIViewController {
    @IBOutlet weak var IssueTitle: UILabel!
    @IBOutlet weak var openLabel: UIButton!
    @IBOutlet weak var closeLabel: UIButton!
    @IBOutlet weak var writeDescriptionLabel: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
