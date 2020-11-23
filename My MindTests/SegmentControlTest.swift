//
//  SegmentControlTest.swift
//  My MindTests
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import XCTest
@testable import My_Mind

final class SegmentControlTest: XCTestCase {
    private let mockDelegate = MockSegmentDelegate()
    private let dataProviderDelegate = MockCategoryDataProviderDelegate()
    private var dataProvider: CategoryDataProvider!

    override func setUp() {
        super.setUp()
        dataProvider = CategoryDataProvider(delegate: dataProviderDelegate)
    }

    func testSegmentView() throws {
        let allCategoryTypes = dataProvider.getCategoryTypes()
        let segmentFrame = CGRect(x: 0, y: 0, width: 200, height: 50)
        let segmentControl = CategorySegmentControl(frame: segmentFrame, categories: allCategoryTypes, delegate: mockDelegate)
        segmentControl.draw(segmentFrame)
        

        let stackView = try segmentControl.getView(CategorySegmentControl.Identifiers.segmentControlStack)
        XCTAssertNotNil(stackView)

        let buttons = stackView.getSubviews(matching: UIButton.self)
        XCTAssertNotNil(buttons)
        XCTAssertEqual(buttons.count, allCategoryTypes.count, "Segment buttons not matching the category type count")
        let exploreButton: UIButton = try stackView.getView(CategorySegmentControl.Identifiers.button(.explore))
        
        XCTAssertNotNil(exploreButton)
        exploreButton.sendActions(for: .touchUpInside)
        
        XCTAssertEqual(mockDelegate.spy.type, .explore, "Button tap not working for Segment control")
    
    }
}
