//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/08.
//

import UIKit

class IssueListViewController: UIViewController {
    @IBOutlet weak var issueListTableView: UITableView!
    @IBOutlet weak var writeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeBarButton()
        self.configureWriteButton()
    }
    
    private func configureWriteButton() {
        self.writeButton.layer.cornerRadius = self.writeButton.frame.width / 2
        self.writeButton.layer.masksToBounds = false
        self.writeButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.writeButton.layer.shadowOffset = CGSize(width: 2.0, height: 3.0)
        self.writeButton.layer.shadowOpacity = 0.7
        self.writeButton.layer.shadowRadius = 0.5
    }
    
    private func makeBarButton() {
        let rightBarImageButton = UIBarButtonItem(image: UIImage(systemName: "checkmark.circle"), style: .plain, target: self, action: #selector(selectIssue(_:)))
        self.tabBarController?.navigationItem.leftBarButtonItem = rightBarImageButton
        let leftBarImageButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .plain, target: self, action: #selector(filterIssue(_:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = leftBarImageButton
    }
    
    @objc func filterIssue(_ sender: UIBarButtonItem) {
        print("filter")
    }
    
    @objc func selectIssue(_ sender: UIBarButtonItem) {
        print("select")
    }
}

extension IssueListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

extension IssueListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IssueListTableViewCell.className) as? IssueListTableViewCell else { return UITableViewCell() }
        cell.title.text = "title"
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completion) in
            print("delete")
        }
        let deleteImage = UIImage(systemName: "trash")
        delete.image = deleteImage

        let close = UIContextualAction(style: .destructive, title: "닫기") { (action, view, completion) in
            print("modify")
        }
        let closeImage = UIImage(systemName: "archivebox")
        close.image = closeImage
        close.backgroundColor = UIColor.init("#CCD4FF", alpha: 1)
        return UISwipeActionsConfiguration(actions: [close, delete])
    }
    
}
