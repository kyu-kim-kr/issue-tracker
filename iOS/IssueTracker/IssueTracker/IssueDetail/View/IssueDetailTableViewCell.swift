//
//  IssueDetailTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/22.
//

import UIKit
import MarkdownView

protocol CellReloadable: class {
    func cellBeginUpdates()
    func cellEndUpdates()
}

class IssueDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var beforeDateLabel: UILabel!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var contentsViewHeight: NSLayoutConstraint!
    
    weak var delegate: CellReloadable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImage.image = nil
        self.userLabel.text = ""
        self.beforeDateLabel.text = ""
        self.contentsView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    func configure(issue: Issue) {
        self.delegate?.cellBeginUpdates()
        ImageLoader.load(from: issue.author.avatarURL) { (image) in
            self.profileImage.image = image?.roundedImage
        }
        self.userLabel.text = issue.author.name
        self.beforeDateLabel.text = issue.createdTime.passingDate
        self.makeMarkdownView(body: issue.issueDescription)
    }
    
    private func makeMarkdownView(body: String) {
        let md = MarkdownView()
        md.load(markdown: body, enableImage: true)
        setContentsViewWhenLoad(markDownView: md)
        self.contentsView.addSubview(md)
        md.translatesAutoresizingMaskIntoConstraints = false
        md.topAnchor.constraint(equalTo: self.contentsView.topAnchor).isActive = true
        md.bottomAnchor.constraint(equalTo: self.contentsView.bottomAnchor).isActive = true
        md.rightAnchor.constraint(equalTo: self.contentsView.rightAnchor).isActive = true
        md.leftAnchor.constraint(equalTo: self.contentsView.leftAnchor).isActive = true
    }
    
    private func setContentsViewWhenLoad(markDownView: MarkdownView) {
        markDownView.onRendered = { [weak self] height in
            self?.contentsViewHeight.constant = height
            self?.delegate?.cellEndUpdates()
        }
    }
}
