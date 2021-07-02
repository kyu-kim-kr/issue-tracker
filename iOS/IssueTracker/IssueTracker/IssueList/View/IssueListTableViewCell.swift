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
    private var issueListCenter: IssueListCenter!
    private var currentCellIndex: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelCollectionView.delegate = self
        self.labelCollectionView.dataSource = self
        self.registerNib()
        self.setLabelCollectionViewFlowLayout()
    }
    
    override func prepareForReuse() {
        self.labelCollectionView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setIssueListCenter(_ issueListCenter: IssueListCenter) {
        self.issueListCenter = issueListCenter
    }
    
    func configure(indexPath: IndexPath, tableView: UITableView) {
        tableView.beginUpdates()
        let labelCount = issueListCenter.issueList[indexPath.row].labelList.count
        if labelCount != 0 {
            labelCollectionView.isHidden = false
        }
        self.currentCellIndex = indexPath.row
        let issue = self.issueListCenter.issueList[indexPath.row]
        self.title.text = issue.title
        self.issueDescroption.text = issue.issueDescription
        self.milestone.text = issue.milestoneTitle
        self.labelCollectionView.reloadData()
        tableView.endUpdates()
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
        guard let issueListCenter = issueListCenter else { return 0 }
        let labelCount = issueListCenter.issueList[currentCellIndex].labelList.count
        
        return labelCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.className, for: indexPath) as? LabelCollectionViewCell else { return UICollectionViewCell() }
        guard let issueListCenter = issueListCenter else { return cell }
        let label = issueListCenter.issueList[currentCellIndex].labelList[indexPath.row]
        cell.configure(text: label.title, backgroundColor: UIColor.init(label.hex))
        return cell
    }
}

extension IssueListTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let issueListCenter = issueListCenter,
              let cellIndex = currentCellIndex else { return CGSize() }
        let label = issueListCenter.issueList[cellIndex].labelList[indexPath.row]
        var size = label.title.size(withAttributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
        ])
        size.width = size.width + 40
        size.height = 30
        return size
    }
}
