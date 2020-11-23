//
//  My_MindUITests.swift
//  My MindUITests
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import XCTest
@testable import My_Mind

class My_MindUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppNavigation() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let firstChild = app.collectionViews.children(matching:.any).element(boundBy: 0)
        if firstChild.exists {
             firstChild.tap()
        }
        
        let followButton = app.buttons["buttonFollow"]
        XCTAssertTrue(followButton.exists)
        XCTAssertEqual(followButton.label, "Following", "Follow button text not matching")
        followButton.tap()
        XCTAssertEqual(followButton.label, "Follow", "Follow button text not matching")

    }
}
