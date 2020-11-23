//
//  NewsDetailsViewController.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet private weak var imageViewHeader: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelProvider: UILabel!
    @IBOutlet private weak var labelDatePublished: UILabel!
    @IBOutlet private weak var textViewDescription: UITextView!

    private var titleValue: String?
    private var newsFeed: NewsFeed?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = .brandPurple
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = .brandWhite
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brandWhite]
        
        let closeBarButtonItem = UIBarButtonItem( image: UIImage(named: "icon_navbar_close"), style: .done, target: self, action: #selector(self.popViewController))

        self.navigationItem.rightBarButtonItem = closeBarButtonItem
        
        setUpViews()
        updateData()
        
    }
    
    @objc func popViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureView(with title: String, feed: NewsFeed) {
        titleValue = title
        newsFeed = feed
    }
}

private extension NewsDetailsViewController {
     func setUpViews() {
        labelTitle.font = .titleChannel
        labelTitle.textColor = .brandWhite
        labelTitle.numberOfLines = 0
        
        labelProvider.font = .titleThumbnail
        labelProvider.textColor = .brandBlack
        
        labelDatePublished.font = .titleThumbnail
        labelDatePublished.textColor = .brandBlack
        
        
        textViewDescription.font = .titleThumbnail
        textViewDescription.textColor = .brandBlack
    }
    
    func updateData() {
        self.title = titleValue?.uppercased()

        imageViewHeader.download(from: newsFeed?.image?.url ?? "")
        labelTitle.text = newsFeed?.title
        labelProvider.text = newsFeed?.provider.name
        labelDatePublished.text = newsFeed?.datePublished.formatDate()
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.paragraphSpacing = 10
        let attributes = [NSAttributedString.Key.paragraphStyle : style]
        textViewDescription.attributedText = NSAttributedString(string: newsFeed?.body ?? ""
                                                                , attributes:attributes)

    }
}
