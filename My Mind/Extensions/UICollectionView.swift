//
//  UICollectionView.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

public extension UICollectionView {
    /// Constructs a UICollectionView using a CollectionViewCoordinator
    ///
    /// Note that this initializer will set the _layout_, _dataSource_, _delegate_ and register any required cells
    /// - Parameter coordinator: The coordinator used to create  the CollectionView
    convenience init(coordinator: CollectionViewCoordinator) {
        self.init(frame: .zero, collectionViewLayout: coordinator.collectionViewlayout)
        dataSource = coordinator
        delegate = coordinator
        coordinator.registerCells(in: self)
    }
}

// MARK: - Cells
public extension UICollectionView {
    /// Registers a UICollectionViewCell with the collection view, using the name of the cell as the identifier
    /// - Parameters:
    ///   - cell: The cell to register
    ///   - bundle: If the bundle parameter is nil, the main bundle is used.
    func register(nib cell: UICollectionViewCell.Type, bundle: Bundle?) {
        register(cell.makeNib(bundle: bundle), forCellWithReuseIdentifier: cell.identifier)
    }

    /// Registers a UICollectionViewCell with the collection view, using the name of the cell as the identifier
    /// - Parameter cell: The cell to register
    func register(cell: UICollectionViewCell.Type) {
        register(cell, forCellWithReuseIdentifier: cell.identifier)
    }

    /// Dequeue a cell where the identifier has the same name as the cell
    /// - Parameter indexPath: The indexPath of the cell
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        #if DEBUG

        guard T.identifier != String(describing: UICollectionViewCell.self) else {
            preconditionFailure("You have not specified the generic type of T. You should use the format: 'let cell: SomeCellType = collectionView.dequeueCell(indexPath)'")
        }

        #endif

        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            preconditionFailure("Cell is not a type of '\(T.self)'")
        }

        return cell
    }
}

// MARK: - Headers
public extension UICollectionView {
    /// Registers a UICollectionReusableView header _xib_ with the collection view
    /// - Parameters:
    ///   - view: The view to register
    ///   - bundle: If the bundle parameter is nil, the main bundle is used.
    func registerHeader(nib view: UICollectionReusableView.Type, bundle: Bundle?) {
        register(view.makeNib(bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: view.identifier)
    }

    /// Dequeue a header view
    /// - Parameter indexPath: The indexPath of the header
    func dequeueHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        #if DEBUG

        guard T.identifier != String(describing: UICollectionReusableView.self) else {
            preconditionFailure("You have not specified the generic type of T. You should use the format: 'let view: SomeViewType = collectionView.dequeueHeader(indexPath)'")
        }

        #endif

        guard let headerView = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            preconditionFailure("Header is not a type of '\(T.self)'")
        }

        return headerView
    }
}
