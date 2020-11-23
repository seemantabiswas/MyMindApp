//
//  CollectionViewCoordinator.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

/// Coordinator for UICollectionViews
public protocol CollectionViewCoordinator: UICollectionViewDataSource, UICollectionViewDelegate {
    /// The layout for the collection view
    var collectionViewlayout: UICollectionViewLayout { get }

    /// Registers the cells in the collectionView
    /// - Parameter collectionView: The collectionView to register the cells in
    func registerCells(in collectionView: UICollectionView)
}
