//
//  MockCategoryListDelegate.swift
//  My MindTests
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import My_Mind
@testable import My_Mind

public class MockCategoryListDelegate: CategoryScrollViewDelegate {
    public let spy = Spy()

    public init() {}

    public func didSelectCategory(categroy: CategoryItem) {
        spy.categroy = categroy
    }
}

public extension MockCategoryListDelegate {
    class Spy {
        public var categroy: CategoryItem?
    }
}
