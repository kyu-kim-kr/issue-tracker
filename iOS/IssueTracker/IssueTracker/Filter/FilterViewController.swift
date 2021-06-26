//
//  FilterViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet var filterStatusDataCenter: FilterStatusDataCenter!
    var gettingFilterdListHandler: ((Filterable?) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedItem = self.filterStatusDataCenter.categoryItems[indexPath.section][indexPath.row]
        selectedItem.isSelected = true
        self.filterStatusDataCenter.deselectAllCagegory()
        self.filterStatusDataCenter.selected = selectedItem
        tableView.reloadData()
        dismiss(animated: true) { [weak self] in
            self?.gettingFilterdListHandler?(self?.filterStatusDataCenter.selected)
        }
    }
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        header.backgroundColor = .systemGray5
        let headerLabel = FilterTableViewHeaderLabel(frame: header.bounds)
        headerLabel.text = FilterStatusDataCenter.Section.allCases[section].description
        headerLabel.font = .systemFont(ofSize: 15)
        headerLabel.textColor = .darkGray
        header.addSubview(headerLabel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterStatusDataCenter.categoryItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.className) as? FilterTableViewCell else { return UITableViewCell() }
        let item = self.filterStatusDataCenter.categoryItems[indexPath.section][indexPath.row]
        cell.confitgure(item: item)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return FilterStatusDataCenter.Section.allCases.count
    }
}
