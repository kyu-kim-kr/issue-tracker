//
//  WriteViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/20.
//

import UIKit
import MarkdownView
import PhotosUI
import Vision

class WriteViewController: UIViewController {
    @IBOutlet weak var markdownTextView: MarkdownTextView!
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
        self.markdownView = makeMarkdownView()
        self.setNavigationController()
        self.setMarkdownTextView()
        self.setSegmentedControl()
        self.checkfilledText()
        self.configureImageMenuItem()
        self.markdownTextView.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? SelectCategoryViewController
        vc?.setWriteInfoDataCenter(self.writeInfoDataCenter)
    }
    
    //MARK: - 이미지 네트워크 시 사용해야함
    private func recognizeText() {
        //MARK: - 이미지 수정해야 함
        guard let cgImage = UIImage(named: "text")?.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest { [weak self] (request, error) in
            guard let observation = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }
            let text = observation.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            if let isContainCode = self?.isContainCode(of: text), isContainCode {
                DispatchQueue.main.async {
                    self?.askPasteOCRCode(text: "```\n\(text)\n```")
                }
            }
        }
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    private func isContainCode(of text: String) -> Bool {
        return text.match(for: "[\\{\\}]+|[\\[\\]]+|[\\(\\)]+|[\\=]+")
    }
    
    private func askPasteOCRCode(text: String) {
        let alert = UIAlertController(title: "이미지 속에 코드가 있습니다. \n인식해서 붙여넣을까여?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        let admit = UIAlertAction(title: "확인", style: .destructive) { [weak self] (_) in
            self?.markdownTextView.text = text
            self?.writeInfoDataCenter.appendBody(text)
        }
        alert.addAction(cancel)
        alert.addAction(admit)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    private func configureImageMenuItem() {
        let imageMenuItem = UIMenuItem(title: "Insert Photo", action: #selector(openPhotoLibrary))
        UIMenuController.shared.menuItems = [imageMenuItem]
    }
    
    @objc private func openPhotoLibrary() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { (authorizationStatus) in
        }
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
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
            self.markdownView.load(markdown: self.writeInfoDataCenter.selectedLabelInfo.bodyDescription, enableImage: true)
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
    
    @IBAction func changedTitleValue(_ sender: UITextField) {
        self.writeInfoDataCenter.saveTitle(sender.text)
        checkfilledText()
    }
    
    private func setNavigationController() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
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

extension WriteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    //MARK: - 이미지를 네트워크로 보내고 주소를 받아야 함
                }
            }
        }
        
    }
}
