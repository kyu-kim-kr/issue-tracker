//
//  LabelListTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import UIKit

class LabelListTableViewCell: UITableViewCell {
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var displayLabelWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(labelInfo: Label) {
        self.displayLabel.text = labelInfo.title
        self.displayLabel.backgroundColor = UIColor.init(labelInfo.colorCode)
        self.displayLabel.textColor = UIColor.init(named: labelInfo.textColor)
        
        self.descriptionLabel.text = labelInfo.labelDescription
        var size = (self.displayLabel.text ?? "").size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ])
        size.width = size.width + 40
        displayLabelWidth.constant = size.width
        print(displayLabel.frame, displayLabel.bounds)
        self.descriptionLabel.sizeToFit()
        self.displayLabel.layer.masksToBounds = true
        self.displayLabel.layer.cornerRadius = size.width / 10
        
    }
}
