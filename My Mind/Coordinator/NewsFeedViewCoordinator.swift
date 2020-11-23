//
//  NewsFeedViewCoordinator.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import UIKit
import Foundation

protocol NewsFeedViewCoordinatorDelegate: AnyObject {
    func didSelectFeed(feed: NewsFeed)
    func didTapFollow(for category: CategoryItem)
}

class NewsFeedViewCoordinator: NSObject, CollectionViewCoordinator {
    
    private let newFeeds: [NewsFeed]
    private let category: CategoryItem

    private weak var delegate: NewsFeedViewCoordinatorDelegate?
    
    let collectionViewlayout: UICollectionViewLayout = UICollectionViewFlowLayout()
    
    init(category: CategoryItem, newFeeds: [NewsFeed], delegate: NewsFeedViewCoordinatorDelegate) {
        self.newFeeds = newFeeds
        self.category = category
        self.delegate = delegate
    }
    
    /// Registers the cells in the collectionView
    /// - Parameter collectionView: The collectionView to register the cells in
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(nib: NewsFeedListCell.self, bundle: .main)
        collectionView.registerHeader(nib: NewsFeedHeaderReusableView.self, bundle: .main)
    }
}

// MARK: Collection View DataSource
extension NewsFeedViewCoordinator: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NewsFeedListCell = collectionView.dequeueCell(for: indexPath)
        let feed = newFeeds[indexPath.row]
        cell.configureView(with: feed)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView: NewsFeedHeaderReusableView = collectionView.dequeueHeader(for: indexPath)
            headerView.delegate = self
            headerView.configureView(with: category)
            return headerView
        case UICollectionView.elementKindSectionFooter:
            return UICollectionReusableView()
            
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: Collection View Delegate
extension NewsFeedViewCoordinator: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feed = newFeeds[indexPath.row]
        delegate?.didSelectFeed(feed: feed)
    }
}

// MARK: Collection View FlowLayout Delegate
extension NewsFeedViewCoordinator: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: HeightConstants.cellHeight)
    }
    
    /// Header Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: HeightConstants.headerHeight)
    }

    /// Footer Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension NewsFeedViewCoordinator: NewsFeedHeaderReusableViewDelegate {
    func didFollow() {
        delegate?.didTapFollow(for: category)
    }
    
}

extension NewsFeedViewCoordinator {
    struct HeightConstants {
        static let cellHeight = CGFloat(110)
        static let headerHeight = CGFloat(250)
    }
}


