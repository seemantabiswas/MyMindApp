//
//  CategoryListCordinator.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit
import Foundation

protocol CategoryListCordinatorDelegate: AnyObject {
    func didSelect(category: CategoryItem)
}

class CategoryListCordinator: NSObject, CollectionViewCoordinator {
    static let imagePadding = 10
    
    private let dataList: [CategoryItem]
    private weak var delegate: CategoryListCordinatorDelegate?
    let collectionViewlayout: UICollectionViewLayout = UICollectionViewFlowLayout()
    
    init(dataList: [CategoryItem], delegate: CategoryListCordinatorDelegate) {
        self.dataList = dataList
        self.delegate = delegate
    }
    
    /// Registers the cells in the collectionView
    /// - Parameter collectionView: The collectionView to register the cells in
    func registerCells(in collectionView: UICollectionView) {
        collectionView.register(cell: HomeCategoryTileCell.self)
    }
}

// MARK: Collection View DataSource
extension CategoryListCordinator: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HomeCategoryTileCell = collectionView.dequeueCell(for: indexPath)
        let category = dataList[indexPath.row]
        cell.configure(with: category)
        return cell
        
    }
}

// MARK: Collection View Delegate
extension CategoryListCordinator: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(category: dataList[indexPath.row])
    }
}

// MARK: Collection View FlowLayout Delegate
extension CategoryListCordinator: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspectRatio: CGFloat = 1

        let width = collectionView.frame.width  / 2
        let height: CGFloat = width / aspectRatio
        return CGSize(width: width, height: height)
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


