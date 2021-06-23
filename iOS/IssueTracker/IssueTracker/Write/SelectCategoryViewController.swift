//
//  SelectCategoryViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/21.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    @IBOutlet weak var categoryTableView: UITableView!
    var writeInfoDataCenter: WriteInfoDataCenter!
    var issueListCenter: IssueListCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.writeInfoDataCenter.getAllCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func touchSaveButton(_ sender: UIBarButtonItem) {
        self.writeInfoDataCenter.makeIssue { [weak self] in
            self?.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    func setWriteInfoDataCenter(_ center: WriteInfoDataCenter) {
        self.writeInfoDataCenter = center
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
            cell.configure(categoryName: "레이블", selectedCategory: self.writeInfoDataCenter.selectLabel?.title)
        case 1:
            cell.configure(categoryName: "마일스톤", selectedCategory: self.writeInfoDataCenter.selectMilestone?.title)
        case 2:
            cell.configure(categoryName: "담당자", selectedCategory: self.writeInfoDataCenter.selectAssign?.name)
        default:
            break
        }
        return cell
    }
}

extension SelectCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: DetailCategoryViewController.className) as? DetailCategoryViewController else { return }
        vc.setCategoryDataCenter(self.writeInfoDataCenter)
        switch indexPath.row {
        case 0: self.writeInfoDataCenter.selectedCategory = .label(self.writeInfoDataCenter.labelList)
        case 1: self.writeInfoDataCenter.selectedCategory = .milestone(self.writeInfoDataCenter.milestoneList)
        case 2: self.writeInfoDataCenter.selectedCategory = .assign(self.writeInfoDataCenter.assignList)
        default: return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
