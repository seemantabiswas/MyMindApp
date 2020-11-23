//
//  ViewIndtifyable.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

public protocol ViewIdentifiable: AnyObject { }

public extension ViewIdentifiable {
    /// Provides an identifier for the cell - the name is based off of the cells name.
    ///
    /// If a cell is called _SomeCell_, the identifier would be _SomeCell_
    static var identifier: String {
        String(describing: self)
    }

    /// Makes a nib for the view
    /// - Parameter bundle: If the bundle parameter is nil, the main bundle is used.
    static func makeNib(bundle: Bundle?) -> UINib {
        UINib(nibName: identifier, bundle: bundle)
    }
}

extension UICollectionReusableView: ViewIdentifiable {}

