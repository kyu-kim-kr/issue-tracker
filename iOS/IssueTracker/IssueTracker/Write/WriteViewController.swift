//
//  WriteViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/20.
//

import UIKit
import MarkdownView

class WriteViewController: UIViewController {
    @IBOutlet weak var markdownTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var titleFieldBottomBorderView: UIView!
    @IBOutlet weak var markdownSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nextBarButton: UIBarButtonItem!
    var markdownView: MarkdownView!
    var writeInfoDataCenter: WriteInfoDataCenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.writeInfoDataCenter = WriteInfoDataCenter()
        self.setNavigationController()
        self.setMarkdownTextView()
        self.markdownView = makeMarkdownView()
        self.setSegmentedControl()
        self.checkfilledText()
    }
    
    private func checkfilledText() {
        if self.titleTextField.text == "" || self.markdownTextView.text == "" {
            self.nextBarButton.isEnabled = false
        } else {
            self.nextBarButton.isEnabled = true
        }
    }
    
    private func setSegmentedControl() {
        self.markdownSegmentedControl.addTarget(self, action: #selector(changedValueInSegmentedControl(_:)), for: .valueChanged)
    }
    
    @objc private func changedValueInSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.markdownView.isHidden = true
            self.markdownView.subviews.forEach { (view) in
                view.removeFromSuperview()
            }
            self.markdownTextView.isHidden = false
        case 1:
            self.markdownTextView.isHidden = true
            self.markdownView.load(markdown: self.writeInfoDataCenter.body, enableImage: true)
            self.markdownView.isHidden = false
        default:
            break
        }
    }
    
    private func setMarkdownTextView() {
        self.markdownTextView.delegate = self
        self.markdownTextView.textColor = .lightGray
        self.markdownTextView.text = "코멘트는 여기에 작성하세요"
    }
    
    private func makeMarkdownView() -> MarkdownView {
        let md = MarkdownView()
        md.load(markdown: nil, enableImage: true)
        self.bodyView.addSubview(md)
        md.translatesAutoresizingMaskIntoConstraints = false
        md.topAnchor.constraint(equalTo: self.bodyView.topAnchor).isActive = true
        md.bottomAnchor.constraint(equalTo: self.bodyView.bottomAnchor).isActive = true
        md.rightAnchor.constraint(equalTo: self.bodyView.rightAnchor).isActive = true
        md.leftAnchor.constraint(equalTo: self.bodyView.leftAnchor).isActive = true
        md.isHidden = true
        return md
    }
    
    @IBAction func titleValueChanged(_ sender: UITextField) {
        self.writeInfoDataCenter.saveTitle(sender.text)
        checkfilledText()
    }
    
    private func setNavigationController() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension WriteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.writeInfoDataCenter.saveBody(textView.text)
        checkfilledText()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "코멘트는 여기에 작성하세요"
            textView.textColor = .lightGray
        }
    }
}
