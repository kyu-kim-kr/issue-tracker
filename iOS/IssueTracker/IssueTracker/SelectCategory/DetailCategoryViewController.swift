//
//  DetailCategoryViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import UIKit

class DetailCategoryViewController: UIViewController {
    var categoryDataCenter: CategoryDataCenter!
    @IBOutlet weak var DetailCategoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setCategoryDataCenter(_ center: CategoryDataCenter) {
        self.categoryDataCenter = center
    }

}

extension DetailCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryDataCenter.selectedItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailCategoryTableViewCell.className) as? DetailCategoryTableViewCell else { return UITableViewCell() }
        switch self.categoryDataCenter.selectedCategory {
        case .label(let labelList):
            cell.configure(name: labelList[indexPath.row].title)
        case .milestone(let milestoneList):
            cell.configure(name: milestoneList[indexPath.row].title)
        case .assign(let assignList):
            cell.configure(name: assignList[indexPath.row].name)
        default: break
        }
        return cell
    }
}

extension DetailCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.categoryDataCenter.selectedItem(of: indexPath.row)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
