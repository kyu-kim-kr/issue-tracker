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

protocol EmojiCallable: class {
    func getEmoji(index: Int) -> Emoji
    func countEmojiData() -> Int
}

class IssueDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var beforeDateLabel: UILabel!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var contentsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var emojiCollectionView: UICollectionView!
    @IBOutlet weak var emojicollectionViewHeight: NSLayoutConstraint!
    
    weak var delegate: CellReloadable?
    weak var emojiDelegate: EmojiCallable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        emojiCollectionView.delegate = self
        emojiCollectionView.dataSource = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .white
        self.emojicollectionViewHeight.constant = 30
        self.profileImage.image = nil
        self.userLabel.text = ""
        self.beforeDateLabel.text = ""
        self.contentsView.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
    
    func configure(issue: Issue) {
        self.delegate?.cellBeginUpdates()
        self.backgroundColor = .systemGray6
        ImageLoader.load(from: issue.author.avatarURL) { (image) in
            self.profileImage.image = image?.roundedImage
        }
        self.userLabel.text = issue.author.name
        self.beforeDateLabel.text = issue.createdTime.passingDate
        self.makeMarkdownView(body: issue.issueDescription, isComment: false)
    }
    
    func configure(comment: Comment) {
        self.delegate?.cellBeginUpdates()
        ImageLoader.load(from: comment.author.avatarURL) { (image) in
            self.profileImage.image = image?.roundedImage
        }
        userLabel.text = comment.author.name
        beforeDateLabel.text = comment.createdTime.passingDate
        makeMarkdownView(body: comment.commentDescription)
    }
    
    private func makeMarkdownView(body: String, isComment: Bool = true) {
        let md = MarkdownView()
        if !isComment { md.backgroundColor = .systemGray6 }
        md.load(markdown: body, enableImage: true)
        setContentsViewWhenLoad(markDownView: md)
        self.contentsView.addSubview(md)
        md.translatesAutoresizingMaskIntoConstraints = false
        md.topAnchor.constraint(equalTo: self.contentsView.topAnchor).isActive = true
        md.bottomAnchor.constraint(equalTo: self.contentsView.bottomAnchor).isActive = true
        md.rightAnchor.constraint(equalTo: self.contentsView.rightAnchor).isActive = true
        md.leftAnchor.constraint(equalTo: self.contentsView.leftAnchor, constant: -15).isActive = true
    }
    
    private func setContentsViewWhenLoad(markDownView: MarkdownView) {
        markDownView.isScrollEnabled = false
        markDownView.onRendered = { [weak self] height in
            self?.contentsViewHeight.constant = height
            self?.delegate?.cellEndUpdates()
        }
    }
}

extension IssueDetailTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 35, height: 35)
    }
}

extension IssueDetailTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let emojiCount = self.emojiDelegate?.countEmojiData() else { return 0 }
        return emojiCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.className, for: indexPath) as? EmojiCollectionViewCell else { return UICollectionViewCell() }
        guard let emojiData = self.emojiDelegate?.getEmoji(index: indexPath.row) else { return cell }
        cell.isHidden = emojiData.selected
        cell.emojiButton.setTitle(emojiData.emoji, for: .normal)
        return cell
    }
}
