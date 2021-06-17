//
//  LabelCollectionViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/09.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: CellLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setLabelLayer() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
    
    func configure(text: String, backgroundColor: UIColor) {
        self.cellLabel.text = "\(text)"
        self.backgroundColor = backgroundColor
        self.setLabelLayer()
        self.cellLabel.sizeToFit()
    }
}
