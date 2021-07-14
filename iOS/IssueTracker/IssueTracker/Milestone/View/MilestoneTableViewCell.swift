//
//  MilestoneTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import UIKit

class MilestoneTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var milestoneDescription: UILabel!
    @IBOutlet weak var due: UILabel!
    @IBOutlet weak var openIssue: UIButton!
    @IBOutlet weak var closeIssue: UIButton!
    @IBOutlet weak var issueProgress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setIssueLayer(openIssue)
        self.setIssueLayer(closeIssue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(milestone: Milestone) {
        self.title.text = milestone.title
        self.milestoneDescription.text = milestone.milestoneDescription
        self.due.text = milestone.due
        self.openIssue.setTitle("열린 이슈 \(milestone.opendIssueCount)개", for: .normal)
        self.closeIssue.setTitle("닫힌 이슈 \(milestone.closedIssueCount)개", for: .normal)
        self.issueProgress.text = milestone.issueProgress
        
    }
    
    private func setIssueLayer(_ issue: UIButton) {
        issue.layer.masksToBounds = true
        issue.layer.cornerRadius = self.openIssue.frame.width / 15
        issue.layer.borderWidth = 1
        issue.layer.borderColor = UIColor.init("#CCD4FF").cgColor
    }
    
}
