//
//  FilterViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/10.
//

import UIKit

class FilterViewController: UIViewController {
    @IBOutlet weak var filterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}

extension FilterViewController: UITableViewDelegate {
    
}

extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ho?"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}
