//
//  MockCategoryDataProviderDelegate.swift
//  My MindTests
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import My_Mind
@testable import My_Mind

public class MockCategoryDataProviderDelegate: CategoryDataProviderDelegate {
    public func showError(messege: String?) {
        spy.showError = true
    }
    
    public let spy = Spy()

    public func didUpdate(with categories: [CategoryItem]) {
        spy.categroies = categories

    }
    public init() {}
}

public extension MockCategoryDataProviderDelegate {
    class Spy {
        public var categroies: [CategoryItem]?
        public var showError = false

    }
}
