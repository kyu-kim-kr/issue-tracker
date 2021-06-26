//
//  FilterTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/26.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var filtertitle: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkImage.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        checkImage.isHidden = !selected
    }
    
    func confitgure(item: Filterable) {
        self.filtertitle.text = item.title
        if item.isSelected == nil || item.isSelected == false {
            checkImage.isHidden = true
        } else {
            checkImage.isHidden = false
        }
    }

}
