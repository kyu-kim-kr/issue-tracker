//
//  IssueListViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/08.
//

import UIKit
import UserNotifications

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
        self.initRefresh()
        self.bind()
        self.configureWriteButton()
        self.issueListCenter.getIssueList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.makeBarButton()
        self.setNavigationController()
        self.issueListTableView.estimatedRowHeight = 300
        self.issueListTableView.rowHeight = 200
    }
    
    @objc private func updateUI(_ refresh: UIRefreshControl) {
        refresh.endRefreshing()
        self.issueListCenter.getIssueList()
    }
    
    private func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.endRefreshing()
        refresh.addTarget(self, action: #selector(updateUI(_:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string: "이슈 새로고침")
        self.issueListTableView.refreshControl = refresh
    }
    
    
    private func bind() {
        self.issueListCenter.listLoadHandler = { issueList in
            self.applySnapshot(issueList: issueList, animatingDifferences: false)
            self.issueListTableView.rowHeight = UITableView.automaticDimension
            self.issueListTableView.estimatedRowHeight = 300
            self.issueListTableView.reloadData()
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "issueWrite" {
            let navVC = segue.destination as? UINavigationController
            let writeVC = navVC?.topViewController as? WriteViewController
            writeVC?.makeWriteInfoDataCenter(reloadHandler: {
                self.issueListCenter.getIssueList()
            })
        } else if segue.identifier == "issueDetail" {
            guard let issue = sender as? Issue else { return }
            let vc = segue.destination as? IssueDetailViewController
            vc?.makeIssueDetailDataCenter(issue: issue)
        }
    }
    
    private func makeDataSource() -> DataSource {
        DataSource.init(tableView: issueListTableView) { (tableView, indexPath, issue) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: IssueListTableViewCell.className, for: indexPath) as? IssueListTableViewCell
            cell?.setIssueListCenter(self.issueListCenter)
            cell?.configure(indexPath: indexPath, tableView: tableView)
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
        self.tabBarController?.navigationItem.hidesSearchBarWhenScrolling = true
        self.tabBarController?.navigationController?.navigationBar.prefersLargeTitles = true
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
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem()
        let leftBarImageButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease"), style: .plain, target: self, action: #selector(filterIssue(_:)))
        self.tabBarController?.navigationItem.leftBarButtonItem = leftBarImageButton
    }
    
    @objc func filterIssue(_ sender: UIBarButtonItem) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: FilterViewController.className) as? FilterViewController else { return }
        self.present(vc, animated: true, completion: nil)
    }
}

extension IssueListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (action, view, completion) in
            print("delete")
            self.askDeleteIssue(index: indexPath.row)
            completion(true)
        }
        let deleteImage = UIImage(systemName: "trash")
        delete.image = deleteImage

        let close = UIContextualAction(style: .destructive, title: "닫기") { (action, view, completion) in
            print("close")
            self.issueListCenter.requestCloseIssue(index: indexPath.row)
            completion(true)
        }
        let closeImage = UIImage(systemName: "archivebox")
        close.image = closeImage
        close.backgroundColor = UIColor.init("#CCD4FF", alpha: 1)
        let swipeConfig = UISwipeActionsConfiguration(actions: [close, delete])
        swipeConfig.performsFirstActionWithFullSwipe = false
        return swipeConfig
    }
    
    private func askDeleteIssue(index: Int) {
        let alert = UIAlertController(title: "정말로 이슈를 삭제하시겠습니까?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        let admit = UIAlertAction(title: "확인", style: .destructive) { [weak self] (_) in
            self?.issueListCenter.requestDeleteIssue(index: index)
            self?.issueListCenter.deleteIssue(index: index)
        }
        alert.addAction(cancel)
        alert.addAction(admit)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let issue = issueListCenter.issueList[indexPath.row]
        performSegue(withIdentifier: "issueDetail", sender: issue)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

