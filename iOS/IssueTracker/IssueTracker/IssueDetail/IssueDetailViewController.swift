//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Issac on 2021/06/18.
//

import UIKit
import MarkdownView

class IssueDetailViewController: UIViewController {
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var openLabel: UIButton!
    @IBOutlet weak var closeLabel: UIButton!
    @IBOutlet weak var writeDescriptionLabel: UILabel!
    @IBOutlet weak var detailView: UIView!
    var issueDetailDataCenter: IssueDetailDataCenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.issueDetailDataCenter = IssueDetailDataCenter()
        
        
//        self.issueDetailDataCenter.issueDetail
        
        
        
        //MARK: - body 요청해서 마크다운 뷰 만들기
    }
    
    private func configureView() {
        let issueDetail = self.issueDetailDataCenter.issueDetail
        
    }
    
    
    private func makeMarkdownView(body: String) -> MarkdownView {
        let md = MarkdownView()
        md.load(markdown: body, enableImage: true)
        self.detailView.addSubview(md)
        md.translatesAutoresizingMaskIntoConstraints = false
        md.topAnchor.constraint(equalTo: self.detailView.topAnchor).isActive = true
        md.bottomAnchor.constraint(equalTo: self.detailView.bottomAnchor).isActive = true
        md.rightAnchor.constraint(equalTo: self.detailView.rightAnchor).isActive = true
        md.leftAnchor.constraint(equalTo: self.detailView.leftAnchor).isActive = true
        return md
    }
}
