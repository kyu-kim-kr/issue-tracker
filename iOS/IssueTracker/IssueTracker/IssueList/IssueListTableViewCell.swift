//
//  IssueListTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/08.
//

import UIKit

class IssueListTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var issueDescroption: UILabel!
    @IBOutlet weak var milestone: UILabel!
    @IBOutlet weak var labelStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
