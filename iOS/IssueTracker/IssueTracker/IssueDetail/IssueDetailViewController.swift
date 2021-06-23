//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit
import MarkdownView

class IssueDetailViewController: UIViewController {
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var openLabel: UIButton!
    @IBOutlet weak var closeLabel: UIButton!
    @IBOutlet weak var writeDescriptionLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var issueIDLabel: UILabel!
    
    var issueDetailDataCenter: IssueDetailDataCenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationController()
        self.configure()
    }
    
    private func setNavigationController() {
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func makeIssueDetailDataCenter(issue: Issue) {
        self.issueDetailDataCenter = IssueDetailDataCenter(issue: issue)
    }
    
    func configure() {
        let issue = self.issueDetailDataCenter.issue
        self.issueTitle.text = issue.title
        self.openLabel.isHidden = issue.closed
        self.closeLabel.isHidden = issue.closed
        self.writeDescriptionLabel.text = ""
        self.issueIDLabel.text = "#\(issue.id)"
        makeMarkdownView(body: issue.issueDescription)
    }
    
    
    private func makeMarkdownView(body: String) {
        let md = MarkdownView()
        md.load(markdown: body, enableImage: true)
        self.detailView.addSubview(md)
        md.translatesAutoresizingMaskIntoConstraints = false
        md.topAnchor.constraint(equalTo: self.detailView.topAnchor).isActive = true
        md.bottomAnchor.constraint(equalTo: self.detailView.bottomAnchor).isActive = true
        md.rightAnchor.constraint(equalTo: self.detailView.rightAnchor).isActive = true
        md.leftAnchor.constraint(equalTo: self.detailView.leftAnchor).isActive = true
    }
}
