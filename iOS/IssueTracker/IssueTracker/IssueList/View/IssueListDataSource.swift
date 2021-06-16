//
//  IssueListDataSource.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import UIKit

enum IssueListSection {
    case main
}

class IssueListDataSource: UITableViewDiffableDataSource<IssueListSection, Issue> {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
