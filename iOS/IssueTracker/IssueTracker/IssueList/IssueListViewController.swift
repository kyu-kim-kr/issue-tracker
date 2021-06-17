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
    private var searchController = UISearchController(searchResultsController: nil)
    private lazy var dataSource = makeDataSource()
    typealias DataSource = IssueListDataSource
    typealias Snapshot = NSDiffableDataSourceSnapshot<IssueListSection, Issue>
    var issueListCenter: IssueListCenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.issueListCenter = IssueListCenter()
        self.bind()
        self.configureWriteButton()
        self.issueListCenter.getIssueList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeBarButton()
        self.setNavigationController()
        self.setupSearchController()
    }
    
    private func bind() {
        self.issueListCenter.listLoadHandler = { issueList in
            self.applySnapshot(issueList: issueList, animatingDifferences: false)
        }
    }
    
    private func makeDataSource() -> DataSource {
        DataSource.init(tableView: issueListTableView) { (tableView, indexPath, issue) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: IssueListTableViewCell.className, for: indexPath) as? IssueListTableViewCell
            cell?.setIssueListCenter(self.issueListCenter)
            cell?.configure(index: indexPath.row)
            return cell
        }
    }
    
    private func applySnapshot(issueList: [Issue], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(issueList)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func setNavigationController() {
        self.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.navigationItem.title = "이슈"
    }
    
    private func setupSearchController() {
        self.tabBarController?.navigationItem.searchController = self.searchController
        self.tabBarController?.navigationItem.searchController?.searchResultsUpdater = self
        self.tabBarController?.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = true
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
        self.tabBarController?.navigationItem.rightBarButtonItem = rightBarImageButton
        let leftBarImageButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .plain, target: self, action: #selector(filterIssue(_:)))
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBarImageButton
    }
    
    @objc func filterIssue(_ sender: UIBarButtonItem) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: FilterViewController.className) as? FilterViewController else { return }
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func selectIssue(_ sender: UIBarButtonItem) {
        print("select")
    }
}

extension IssueListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completion) in
            print("delete")
            self.issueListCenter.deleteIssue(index: indexPath.row)
            completion(true)
        }
        let deleteImage = UIImage(systemName: "trash")
        delete.image = deleteImage

        let close = UIContextualAction(style: .destructive, title: "닫기") { (action, view, completion) in
            print("modify")
        }
        let closeImage = UIImage(systemName: "archivebox")
        close.image = closeImage
        close.backgroundColor = UIColor.init("#CCD4FF", alpha: 1)
        let swipeConfig = UISwipeActionsConfiguration(actions: [close, delete])
        swipeConfig.performsFirstActionWithFullSwipe = false
        return swipeConfig
    }
}

extension IssueListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let query = searchController.searchBar.text
        let issueList = self.issueListCenter.issueList.filter({ $0.title.contains(query ?? "") })
        self.applySnapshot(issueList: issueList)
    }
}
