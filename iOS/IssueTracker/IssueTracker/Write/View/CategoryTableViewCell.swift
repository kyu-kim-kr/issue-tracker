//
//  CategoryTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var selectedCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(categoryName: String, selectedCategory: String?) {
        self.categoryTitle.text = categoryName
        self.selectedCategory.text = selectedCategory
    }

}
