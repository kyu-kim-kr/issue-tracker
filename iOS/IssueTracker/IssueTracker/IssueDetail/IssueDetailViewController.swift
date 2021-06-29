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
    @IBOutlet weak var issueIDLabel: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    var issueDetailDataCenter: IssueDetailDataCenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.estimatedRowHeight = 300
        self.configure()
        self.setNavigationController()
    }
    
    private func setNavigationController() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func makeIssueDetailDataCenter(issue: Issue) {
        self.issueDetailDataCenter = IssueDetailDataCenter(issue: issue)
    }
    
    func configure() {
        let issue = self.issueDetailDataCenter.issue
        self.issueTitle.text = issue.title
        self.openLabel.isHidden = issue.closed
        self.closeLabel.isHidden = !issue.closed
        self.writeDescriptionLabel.text = self.issueDetailDataCenter.titleDescription
        self.issueIDLabel.text = "#\(issue.id)"
    }
}

extension IssueDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
}

extension IssueDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issueDetailDataCenter.comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueDetailTableViewCell.className) as? IssueDetailTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.configure(issue: self.issueDetailDataCenter.issue)
        return cell
        //MARK: - 확인해봐야함
    }
}

extension IssueDetailViewController: CellReloadable {
    func cellBeginUpdates() {
        self.detailTableView.beginUpdates()
    }
    
    func cellEndUpdates() {
        self.detailTableView.endUpdates()
    }
}
