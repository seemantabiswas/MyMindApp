//
//  UIView+Extension.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

extension UIView {
    func setIdentifier(_ identifier: AccessibilityIdentifying) {
        accessibilityIdentifier = identifier.identifier
    }
    
    /// Adds a subview and calls the 'addSafeAreaConstraints' function
    /// - Parameter subView: The subView to add and set constraints to
    func addSubviewWithConstraints(_ subView: UIView) {
        addSubview(subView)
        addConstraints(for: subView)
    }

    /// Adds a subview and calls the 'addSafeAreaConstraints' function
    /// - Parameter subView: The subView to add and set constraints to
    func addSubviewWithSafeAreaConstraints(_ subView: UIView) {
        addSubview(subView)
        addSafeAreaConstraints(for: subView)
    }

    /// Adds constraints to the receiver that pin the subview to its area which includes any margins
    /// for the leading, trailing, top, and bottom attributes - causing the subview to completely fill the area.
    /// - Important: Call after you have added the subview to the receiver (i.e. in the same way you do when adding constraints in general).
    func addConstraints(for subview: UIView, value: CGFloat = 0.0) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: value),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: value),
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: value),
            subview.rightAnchor.constraint(equalTo: rightAnchor, constant: value)
        ])
    }
    
    /// Adds constraints to the receiver that pin the subview to its bottom which includes any margins
    /// for the leading, trailing, and bottom attributes - causing the subview to stick to the bottom part
    func stickToBottom(for subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subview.bottomAnchor.constraint(equalTo: bottomAnchor),
            subview.leftAnchor.constraint(equalTo: leftAnchor),
            subview.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    /// Adds constraints to the receiver that positions the subview at its center.
    /// Call after you have added the subview to the receiver (i.e. in the same way you do when adding constraints in general).
    func addConstraintsCenteringSubview(_ subview: UIView) {
        addEqualMatchingConstraintsForSubview(subview, withAttributes: [.centerX, .centerY])
    }
    
    /// Adds constraints between the subview and the receiver in a way that identical attributes with equal values
    /// are applied (e.g. so can quickly setup constraints so that a subview's leading attribute exactly matches
    /// that of the superview)
    func addEqualMatchingConstraintsForSubview(_ subview: UIView, withAttributes attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat = 1.0, constant: CGFloat = 0.0) {
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: subview, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: multiplier, constant: constant)
            addConstraint(constraint)
        }
    }

    /// Installs two constraints: width and height in the caller
    /// - Parameter width: the width of the constraint to be installed
    /// - Parameter height: the hight of the constraint to be installed
    func addConstraintsForSize(width: CGFloat, height: CGFloat) {
        addConstraint(forWidth: width)
        addConstraint(forHeight: height)
    }

    /// Installs height in the caller
    /// - Parameter height: the height of the constraint to be installed
    /// - Returns: The `NSLayoutConstraint` created
    @discardableResult func addConstraint(forHeight height: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: height)
        addConstraint(constraint)
        return constraint
    }

    /// Installs width in the caller
    /// - Parameter width: the width of the constraint to be installed
    /// - Returns: The `NSLayoutConstraint` created
    @discardableResult func addConstraint(forWidth width: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: width)
        addConstraint(constraint)
        return constraint
    }

    /// Adds constraints to the receiver that pin the subview to its safe area which includes any margins
    /// for the leading, trailing, top, and bottom attributes - causing the subview to completely fill the safe area
    /// but not the whole screen which might render content obscured by the device controls.
    /// - Important: Call after you have added the subview to the receiver (i.e. in the same way you do when adding constraints in general).
    /// - Parameters:
    ///   - subview: a subview to pin to safe area
    ///   - constant: the constant number applied to all 4 sides.
    func addSafeAreaConstraints(for subview: UIView, margin: UIEdgeInsets = UIEdgeInsets.zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: margin.top),
            subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -margin.bottom),
            subview.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: margin.left),
            subview.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -margin.right)
        ])
    }
}
