//
//  NewLabelViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/17.
//

import UIKit

class NewLabelViewController: UIViewController {
    var labelDataCenter: labelDataCenter!
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
        saveButton.isEnabled = checkFillTextField()
        displayingLabel.text = sender.text
        setLabelWidth(of: self.displayingLabel, labelWidth: self.displayingLabelWidth)
    }
    
    @IBAction func hexColorEditingChanged(_ sender: UITextField) {
        if !(sender.text ?? "").match(for: "^#(?:[0-9a-fA-F]{6})") {
            self.displayingLabel.backgroundColor = .clear
            self.saveButton.isEnabled = false
        } else {
            self.displayingLabel.backgroundColor = UIColor.init(sender.text ?? "")
            saveButton.isEnabled = checkFillTextField()
        }
    }
    
    private func checkFillTextField() -> Bool {
        return self.titleTextField.text != "" && self.hexColorTextField.text != ""
    }
    
    @IBAction func colorResetButton(_ sender: UIButton) {
        let letters = "0123456789ABCDEF"
        let hexColorCode = "#" + (0..<6).map({ Int -> String in String(letters.randomElement()!)
        }).joined()
        self.displayingLabel.backgroundColor = UIColor.init(hexColorCode)
        self.hexColorTextField.text = hexColorCode
        saveButton.isEnabled = checkFillTextField()
    }
    
    @IBAction func touchSaveButton(_ sender: UIButton) {
        print("저장")
        dismiss(animated: true, completion: nil)
    }
}
