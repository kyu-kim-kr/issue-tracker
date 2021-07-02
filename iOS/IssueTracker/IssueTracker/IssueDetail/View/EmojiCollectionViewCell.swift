//
//  EmojiCollectionViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/29.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var emojiButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setEmojiLayer()
    }
    
    private func setEmojiLayer() {
        self.emojiButton.layer.cornerRadius = self.emojiButton.frame.width / 4
        self.emojiButton.layer.masksToBounds = true
    }
}
