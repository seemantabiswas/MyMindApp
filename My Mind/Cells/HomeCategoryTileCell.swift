//
//  CategoryCell.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

class HomeCategoryTileCell: UICollectionViewCell {

    // MARK: Creating SubViews
    private let labelCategory: UILabel = {
        let label = UILabel()
        label.textColor = .brandWhite
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .titleThumbnail
        return label
    }()
    
    private let labelBgView: UIView = {
        let labelBg = UIView()
        labelBg.backgroundColor = UIColor.brandBlack.withAlphaComponent(0.3)
        return labelBg
    }()
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        
        contentView.addSubview(bgImageView)
        labelBgView.addSubview(labelCategory)
        contentView.addSubview(labelBgView)

        labelBgView.addConstraints(for: labelCategory)

        labelBgView.addConstraint(forHeight: 30)
        contentView.stickToBottom(for: labelBgView)

        contentView.addSafeAreaConstraints(for: bgImageView, margin: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        contentView.layer.masksToBounds = true
        contentView.layoutIfNeeded()
    }

    func configure(with category: CategoryItem) {
        labelCategory.text = category.name.uppercased()
        bgImageView.image = UIImage(named: category.imageUrl)
    }
}
