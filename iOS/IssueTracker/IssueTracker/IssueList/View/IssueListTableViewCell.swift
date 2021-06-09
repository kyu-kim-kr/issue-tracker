//
//  IssueListTableViewCell.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/08.
//

import UIKit

class IssueListTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var issueDescroption: UILabel!
    @IBOutlet weak var milestone: UILabel!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelCollectionView.delegate = self
        self.labelCollectionView.dataSource = self
        self.registerNib()
        self.setLabelCollectionViewFlowLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setLabelCollectionViewFlowLayout() {
        let layout = LabelFlowLayout()
        layout.minimumInteritemSpacing = 5
        self.labelCollectionView.collectionViewLayout = layout
    }
    
    private func registerNib() {
        let nib = UINib(nibName: LabelCollectionViewCell.className, bundle: nil)
        self.labelCollectionView.register(nib, forCellWithReuseIdentifier: LabelCollectionViewCell.className)
    }

}

extension IssueListTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.className, for: indexPath) as? LabelCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(text: "Hello~!~!~!", backgroundColor: UIColor.init("#ADDF12"))
        return cell
    }
}

extension IssueListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = "Hello~!~!~!".size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ])
        size.width = size.width + 40
        return size
    }
}
