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
        self.configure()
        self.setNavigationController()
    }
    
    private func bind() {
        self.issueDetailDataCenter.reloadHandler = { [weak self] in
            self?.detailTableView.reloadData()
        }
        
        self.issueDetailDataCenter.emojiReloadHandler = { [weak self] in
            self?.detailTableView.reloadData()
        }
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
        self.bind()
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
        return 150
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension IssueDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issueDetailDataCenter.comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueDetailTableViewCell.className) as? IssueDetailTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.emojiDelegate = self
        if indexPath.row == 0 {
            cell.configure(issue: self.issueDetailDataCenter.issue)
        } else {
            cell.configure(comment: self.issueDetailDataCenter.comments[indexPath.row - 1])
        }
        return cell
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


extension IssueDetailViewController: EmojiCallable {
    func countEmojiData() -> Int {
        return self.issueDetailDataCenter.emojiData.count
    }
    
    func getEmoji(index: Int) -> Emoji {
        return self.issueDetailDataCenter.emojiData[index]
    }
}
