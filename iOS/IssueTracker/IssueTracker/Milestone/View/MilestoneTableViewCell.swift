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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setIssueLayer(openIssue)
        self.setIssueLayer(closeIssue)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setIssueLayer(_ issue: UIButton) {
        issue.layer.masksToBounds = true
        issue.layer.cornerRadius = self.openIssue.frame.width / 15
        issue.layer.borderWidth = 1
        issue.layer.borderColor = UIColor.init("#CCD4FF").cgColor
    }
    
}
