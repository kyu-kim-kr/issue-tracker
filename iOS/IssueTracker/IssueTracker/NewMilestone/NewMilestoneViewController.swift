//
//  NewMilestoneViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit

class NewMilestoneViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func titleEditingChanged(_ sender: UITextField) {
        self.saveButton.isEnabled = sender.text == "" ? false : true
    }
    
    @IBAction func dueEditingChanged(_ sender: UITextField) {
        if sender.text == "" || (sender.text ?? "").match(for: "^\\d{4}\\-(0?[1-9]|1[012])\\-(0?[1-9]|[12][0-9]|3[01])$") {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func touchSaveButton(_ sender: UIButton) {
        print("저장")
    }
}
