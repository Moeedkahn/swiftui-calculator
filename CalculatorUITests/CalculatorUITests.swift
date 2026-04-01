//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Moeed Khan on 29/03/2026.
//

import XCTest

final class CalculatorUITests: XCTestCase {
    @MainActor
    func testTappingButtonsShowsResult() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["8"].tap()
        app.buttons["9"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.staticTexts["185"].exists)
    }
}
