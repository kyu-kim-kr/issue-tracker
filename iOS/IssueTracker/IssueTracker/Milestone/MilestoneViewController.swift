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
        
    }
    
    private func makeBarButton() {
        let rightBarImageButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(selectPlusButton(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarImageButton
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    @objc func selectPlusButton(_ sender: UIBarButtonItem) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: NewMilestoneViewController.className) as? NewMilestoneViewController else { return }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension MilestoneViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MilestoneTableViewCell.className, for: indexPath) as? MilestoneTableViewCell else { return UITableViewCell() }
        return cell
    }
}

extension MilestoneViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension MilestoneViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        viewHeaderConstraint.constant = -scrollView.contentOffset.y
    }
}
