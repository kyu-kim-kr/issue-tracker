//
//  NewLabelViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/17.
//

import UIKit

class NewLabelViewController: UIViewController {
    @IBOutlet weak var displayingLabel: UILabel!
    @IBOutlet weak var displayingLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var hexColorTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLabelWidth(of: self.displayingLabel, labelWidth: self.displayingLabelWidth)
    }
    
    private func setLabelWidth(of label: UILabel, labelWidth: NSLayoutConstraint) {
        let fontSize: CGSize = {
            var size = (label.text ?? "").size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)
            ])
            size.width = size.width + 40
            return size
        }()
        labelWidth.constant = fontSize.width
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
    }
    
    @IBAction func titleEditingChanged(_ sender: UITextField) {
        saveButton.isEnabled = sender.text == "" ? false : true
        displayingLabel.text = sender.text
        setLabelWidth(of: self.displayingLabel, labelWidth: self.displayingLabelWidth)
    }
    
    @IBAction func hexColorEditingChanged(_ sender: UITextField) {
        if sender.text?.count ?? 0 > 7 {
            sender.text?.removeLast()
        }
        self.displayingLabel.backgroundColor = UIColor.init(sender.text ?? "")
    }
    
    @IBAction func colorResetButton(_ sender: UIButton) {
        self.displayingLabel.backgroundColor = .white
        self.hexColorTextField.text = "#FFFFFF"
        
    }
    
    @IBAction func touchSaveButton(_ sender: UIButton) {
        print("저장")
    }
}
