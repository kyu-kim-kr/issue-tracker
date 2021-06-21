//
//  DetailCategoryTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import UIKit

class DetailCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var itemTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(name: String) {
        self.itemTitle.text = name
    }
}
