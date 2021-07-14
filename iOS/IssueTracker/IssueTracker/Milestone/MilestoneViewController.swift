//
//  MilestoneViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import UIKit

class MilestoneViewController: UIViewController {
    @IBOutlet weak var milestoneTableView: UITableView!
    @IBOutlet weak var viewHeaderConstraint: NSLayoutConstraint!
    var milestoneDataCenter: MilestoneDataCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.milestoneDataCenter = MilestoneDataCenter()
        self.bind()
        self.setTableView()
        self.milestoneDataCenter.getMilestones()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationController()
        self.makeBarButton()
    }
    
    func setNavigationController() {
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.navigationItem.title = "마일스톤"
        self.tabBarController?.navigationItem.searchController = nil
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setTableView() {
        self.milestoneTableView.rowHeight = 200
    }
    
    func bind() {
        self.milestoneDataCenter.milestoneLoadHandler = {
            self.milestoneTableView.reloadData()
        }
    }
    
    private func makeBarButton() {
        let rightBarImageButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(selectPlusButton(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarImageButton
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    @objc func selectPlusButton(_ sender: UIBarButtonItem) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: NewMilestoneViewController.className) as? NewMilestoneViewController else { return }
        vc.setMilestoneDataCenter(self.milestoneDataCenter)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension MilestoneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.milestoneDataCenter.milestoneList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MilestoneTableViewCell.className, for: indexPath) as? MilestoneTableViewCell else { return UITableViewCell() }
        cell.configure(milestone: self.milestoneDataCenter.milestoneList[indexPath.row])
        return cell
    }
}

extension MilestoneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completion) in
            self.milestoneDataCenter.deleteMilestone(index: indexPath.row) {
                self.milestoneDataCenter.deleteLocalMilestone(index: indexPath.row)
            }
            completion(true)
        }
        let deleteImage = UIImage(systemName: "trash")
        delete.image = deleteImage
        let swipeConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeConfig.performsFirstActionWithFullSwipe = true
        return swipeConfig
    }
}
