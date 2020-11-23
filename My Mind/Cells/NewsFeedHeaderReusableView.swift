//
//  NewsFeedHeaderReusableView.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import UIKit

protocol NewsFeedHeaderReusableViewDelegate: AnyObject {
    func didFollow()
}

public class NewsFeedHeaderReusableView: UICollectionReusableView {

    static let buttonFollowAccessibilityId = "buttonFollow"
    
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var bgImageView: UIImageView!
    @IBOutlet private weak var labelCount: UILabel!
    @IBOutlet private weak var buttonFollow: UIButton!
    
    weak var delegate: NewsFeedHeaderReusableViewDelegate?

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        labelTitle.font = .titleChannel
        labelTitle.textColor = .brandWhite

        labelCount.font = .titleCategory
        labelCount.textColor = .brandWhite
        buttonFollow.layer.cornerRadius = 20
        buttonFollow.backgroundColor = .brandPink
        buttonFollow.layer.borderWidth = 2
        buttonFollow.titleLabel?.font = .titleCategory
        buttonFollow.accessibilityIdentifier = NewsFeedHeaderReusableView.buttonFollowAccessibilityId
        buttonFollow.layer.borderColor = UIColor.brandPink.cgColor

    }
    
    func configureView(with categroy: CategoryItem) {
        labelTitle.text = categroy.name.uppercased()
        labelCount.text = "\(categroy.followers) Followers"
        buttonFollow.setTitle(categroy.associatedTypes.contains(.following) ? "Following" : "Follow", for: .normal)
        buttonFollow.titleLabel?.textColor = .brandWhite
        bgImageView.image = UIImage(named: categroy.imageUrl)
    }
    
    @IBAction func didTapFollow(_ sender: UIButton) {
        if buttonFollow.titleLabel?.text == "Following" {
            buttonFollow.setTitle("Follow", for: .normal)
        } else {
            buttonFollow.setTitle("Following", for: .normal)
        }
        
        delegate?.didFollow()
    }
}

