//
//  LabelViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/16.
//

import UIKit

class LabelViewController: UIViewController {
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var viewHeaderConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelListTableView: UITableView!
    var labelDataCenter: LabelDataCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelDataCenter = LabelDataCenter()
        self.bind()
        self.labelDataCenter.getLabels()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeBarButton()
        self.setNavigationController()
    }
    
    func setNavigationController() {
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.navigationItem.title = "레이블"
        self.tabBarController?.navigationItem.searchController = nil
    }
    
    func bind() {
        self.labelDataCenter.labelLoadHandler = {
            self.labelListTableView.reloadData()
        }
    }
    
    private func makeBarButton() {
        let rightBarImageButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(selectPlusButton(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarImageButton
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
    }
    
    @objc func selectPlusButton(_ sender: UIBarButtonItem) {
        print("추가")
    }
}

extension LabelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO: -
//        return self.labelDataCenter.labelList.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelListTableViewCell.className, for: indexPath) as? LabelListTableViewCell else { return UITableViewCell() }
        //TODO: -
//        cell.configure(labelInfo: self.labelDataCenter.labelList[indexPath.row])
        let labelInfo = Label(id: 1, title: "헬로우", labelDescription: "이것은 설명란입니다", colorCode: "#AD1FF3", textColor: "black")
        cell.configure(labelInfo: labelInfo)
        return cell
    }
}

extension LabelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

extension LabelViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewHeaderConstraint.constant = -scrollView.contentOffset.y
    }
}
