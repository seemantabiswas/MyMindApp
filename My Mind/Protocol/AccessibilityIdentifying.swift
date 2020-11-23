//
//  Accessiblity.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import Foundation

public protocol AccessibilityIdentifying { }

public extension AccessibilityIdentifying {
    var identifier: String {
        "\(String(describing: Self.self)).\(self)"
    }
}
