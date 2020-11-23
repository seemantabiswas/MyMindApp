//
//  NewsFeedListCell.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import UIKit

class NewsFeedListCell: UICollectionViewCell {
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelProvider: UILabel!
    @IBOutlet private weak var labelDatePublished: UILabel!
    
    @IBOutlet private weak var viewDivider: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white

        labelTitle.numberOfLines = 0
        labelTitle.font = .titleCategory
        labelTitle.textColor = .brandBlack
        
        labelProvider.font = .titleThumbnail
        labelProvider.textColor = .brandBlack

        labelDatePublished.font = .titleThumbnail
        labelDatePublished.textColor = .brandBlack
        
        viewDivider.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

    }
    
    func configureView(with feed: NewsFeed) {
        labelTitle.text = feed.title
        labelProvider.text = feed.provider.name
        labelDatePublished.text = feed.datePublished.formatDate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        labelTitle.text = nil
        labelProvider.text = nil
        labelDatePublished.text = nil
    }
    
}
