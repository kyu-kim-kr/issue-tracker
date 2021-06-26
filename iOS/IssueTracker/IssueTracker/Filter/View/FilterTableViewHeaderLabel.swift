//
//  FilterTableViewHeader.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/26.
//

import UIKit

class FilterTableViewHeaderLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let inset = UIEdgeInsets(top: 7, left: 20, bottom: 10, right: 20 )
        super.drawText(in: rect.inset(by: inset))
    }
}
