//
//  UIView+Testing.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import UIKit

extension UIView {
    /// Returns a UIView using the Accessibility Identifier
    /// - Parameter identifier: The identifier of the view
    /// - Returns: The matching UIView of the specified type
    public func getView<T: UIView>(_ identifier: AccessibilityIdentifying) throws -> T {
        let matchingViews: [T] = getSubviews(from: self)

        guard !matchingViews.isEmpty else {
            throw ViewError.typeNotFound(String(describing: T.self))
        }

        guard let matchingView = matchingViews.first(where: { $0.accessibilityIdentifier == identifier.identifier }) else {
            throw ViewError.identifierNotFound(identifier.identifier)
        }

        return matchingView
    }

    /// Returns all the subviews of the specified type
    /// - Parameter type: The type of UIView view to find
    /// - Returns: All matching UIViews of type T
    public func getSubviews<T: UIView>(matching type: T.Type) -> [T] {
        getSubviews(from: self)
    }

    private func getSubviews<T: UIView>(from view: UIView) -> [T] {
        var all = [T]()

        // If the initial view is of Type T, add it
        if let view = view as? T {
            all.append(view)
        }

        // Loop over any subviews (if there are any) and add them to the list
        for subview in view.subviews {
            let results: [T] = getSubviews(from: subview)
            all.append(contentsOf: results)
        }
        return all
    }

}

public enum ViewError: Error {
    /// A view cannot be found using the identifier
    case identifierNotFound(String)
    /// A matching view type cannot be found
    case typeNotFound(String)

    var localizedDescription: String {
        switch self {
        case .identifierNotFound(let identifier):
            return "Could not find view with identifier: '\(identifier)'"
        case .typeNotFound(let type):
            return "Could not find any views of type: `\(type)`"
        }
    }
}
