//
//  MockSegmentDelegate.swift
//  My MindTests
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import My_Mind
@testable import My_Mind

public class MockSegmentDelegate: CategorySegmentControlDelegate {
    public let spy = Spy()

    public init() {}

    public func didSelect(type: CategoryType) {
        spy.type = type
    }
}

public extension MockSegmentDelegate {
    class Spy {
        public var type: CategoryType?
    }
}
