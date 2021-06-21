//
//  SelectCategoryViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    var categoryDataCenter: CategoryDataCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryDataCenter = CategoryDataCenter()
        //MARK: - 카테고리들 각자 다아아아아 요청
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.categoryTableView.reloadData()
    }
}

extension SelectCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.className) as? CategoryTableViewCell else { return UITableViewCell() }
        switch indexPath.row {
        case 0:
            cell.configure(categoryName: "레이블", selectedCategory: self.categoryDataCenter.selectLabel?.title)
        case 1:
            cell.configure(categoryName: "마일스톤", selectedCategory: self.categoryDataCenter.selectMilestone?.title)
        case 2:
            cell.configure(categoryName: "담당자", selectedCategory: self.categoryDataCenter.selectAssign?.name)
        default:
            break
        }
        return cell
    }
}

extension SelectCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: DetailCategoryViewController.className) as? DetailCategoryViewController else { return }
        vc.categoryDataCenter = self.categoryDataCenter
        switch indexPath.row {
        case 0: self.categoryDataCenter.selectedCategory = .label(self.categoryDataCenter.labelList)
        case 1: self.categoryDataCenter.selectedCategory = .milestone(self.categoryDataCenter.milestoneList)
        case 2: self.categoryDataCenter.selectedCategory = .assign(self.categoryDataCenter.assignList)
        default: return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
