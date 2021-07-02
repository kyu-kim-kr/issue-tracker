//
//  NewMilestoneViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit

class NewMilestoneViewController: UIViewController {
    private var milestoneDataCenter: MilestoneDataCenter!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setMilestoneDataCenter(_ center: MilestoneDataCenter) {
        self.milestoneDataCenter = center
    }
    
    @IBAction func titleEditingChanged(_ sender: UITextField) {
        self.saveButton.isEnabled = sender.text == "" ? false : true
        self.milestoneDataCenter.setMilestoneTitle(sender.text ?? "")
    }
    
    @IBAction func descriptionChanged(_ sender: UITextField) {
        self.milestoneDataCenter.setMilestoneDescription(sender.text ?? "")
    }
    
    @IBAction func dueEditingChanged(_ sender: UITextField) {
        if sender.text == "" || (sender.text ?? "").match(for: "^\\d{4}\\-(0?[1-9]|1[012])\\-(0?[1-9]|[12][0-9]|3[01])$") {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        self.milestoneDataCenter.setDate(sender.text ?? "")
    }
    
    @IBAction func touchSaveButton(_ sender: UIButton) {
        self.milestoneDataCenter.makeMilestone { [weak self] in
            self?.dismiss(animated: true, completion: {
                self?.milestoneDataCenter.getMilestones()
            })
        }
    }
}
