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
    var gettingFilterdListHandler: (([String: Int]?) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategory()
    }
    private func getCategory() {
        self.filterStatusDataCenter.getCategory {
            self.filterTableView.reloadData()
        }
    }
    @IBAction func resetSelectedCategory(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.gettingFilterdListHandler?(nil)
        }
    }
}

extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = self.filterStatusDataCenter.categoryItems[indexPath.section][indexPath.row]
        guard let selectedCategory = FilterStatusDataCenter.Section.init(index: indexPath.section) else { return }
        tableView.reloadData()
        dismiss(animated: true) { [weak self] in
            self?.gettingFilterdListHandler?([selectedCategory.rawValue: selectedItem.id])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
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
