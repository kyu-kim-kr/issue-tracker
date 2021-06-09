//
//  CellLabel.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/09.
//

import UIKit

class CellLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        super.drawText(in: rect.inset(by: insets))
    }
}
