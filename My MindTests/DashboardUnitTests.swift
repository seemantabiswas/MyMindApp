//
//  DashboardUnitTests.swift
//  My MindTests
//
//  Created by Seemanta Biswas on 2020-11-23.
//

import XCTest
@testable import My_Mind

final class DashboardUnitTests: XCTestCase {
    private let mockListDelegate = MockCategoryListDelegate()
    private let dataProviderDelegate = MockCategoryDataProviderDelegate()
    private var dataProvider: CategoryDataProvider!
    private var dashBoard: DashBoardViewController!


    override func setUp() {
        super.setUp()
        dataProvider = CategoryDataProvider(delegate: dataProviderDelegate)
        dashBoard = DashBoardViewController()
    }

    func testAllCategories() {
        let allCategoryTypes = dataProvider.getCategoryTypes()
        XCTAssertEqual(allCategoryTypes.count, 3)

        dataProvider.getCategoryList(with: .following)
        XCTAssertEqual(dataProviderDelegate.spy.categroies?.count, 8, "Category count not matching to 8")
        
        dataProvider.getCategoryList(with: .explore)
        XCTAssertEqual(dataProviderDelegate.spy.categroies?.count, 5, "Category count not matching to 8")
    }
    
    func testSegmentControlView() throws {

        dashBoard.viewDidLoad()
        let segmemtControl = try dashBoard.view.getView(DashBoardViewController.Identifiers.categoryTypeFilterView)
        XCTAssertNotNil(segmemtControl)
        let categroyListView  = try dashBoard.view.getView(DashBoardViewController.Identifiers.categroyListView)
        XCTAssertNotNil(categroyListView)
    }

}
