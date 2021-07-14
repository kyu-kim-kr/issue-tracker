//
//  FilterTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/26.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var filtertitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func confitgure(item: Filterable) {
        self.filtertitle.text = item.title
    }

}
