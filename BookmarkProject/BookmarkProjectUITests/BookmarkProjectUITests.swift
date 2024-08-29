//
//  BookmarkProjectUITests.swift
//  BookmarkProjectUITests
//
//  Created by Victor on 25/08/2024.
//

import XCTest

final class BookmarkProjectUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    // MARK: Helpers
    
    func scrollToElement(_ element: XCUIElement, in app: XCUIApplication) {
        while !element.exists || !element.isHittable {
            app.swipeUp()
        }
    }
    
    func dismissKeyboardIfPresent(app: XCUIApplication) {
        if app.keyboards.element(boundBy: 0).exists {
            app.keyboards.buttons["return"].tap()
        }
    }
    
    
    // MARK: Tests
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testAutomaticallyGenerateAssetFlow() {
        let app = XCUIApplication()
        
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        let newAssetTab = tabBar.buttons["New asset"]
        
        newAssetTab.tap()
        
        let urlTextField = app.textFields["Enter URL"]
        
        XCTAssertTrue(urlTextField.exists, "The URL TextField doesn't exist.")
        
        urlTextField.tap()
        urlTextField.typeText("https://example.com/ui-tests")
        
        let generateButton = app.buttons["Generate asset"]
        
        XCTAssertTrue(generateButton.exists, "The 'Generate asset' button doesn't exist.")
        
        /// Due to the randomness of the outcome, neither of the paths below can be reliably implemented, so we will just
        /// end this test early and implement it once a real generate method can be used.
//        generateButton.tap()
//
//        let alert = app.alerts.firstMatch
//        let alertExists = alert.waitForExistence(timeout: 2.1)
//        
//        XCTAssertTrue(alertExists, "An alert was not shown.")
//        XCTAssertEqual(alert.label, "Failed to generate asset", "The alert title is incorrect.")
//        
//        let alertButton = alert.buttons["OK"]
//        
//        XCTAssertTrue(alertButton.exists, "The alert 'OK' button doesn't exist.")
//        
//        alertButton.tap()
//        
//        let newView = app.otherElements["New View"]
//        let exists = newView.waitForExistence(timeout: 2.1)
//        
//        XCTAssertTrue(exists, "The new view didn't appear in time.")
    }
    
    func testManuallyGenerateAssetFlow() {
        let app = XCUIApplication()
        
        app.launch()
        
        let tabBar = app.tabBars["Tab Bar"]
        let newAssetTab = tabBar.buttons["New asset"]
        
        newAssetTab.tap()
        
        let manualButton = app.buttons["Manual button"]
        let manualButtonExists = manualButton.waitForExistence(timeout: 0.1)
        
        XCTAssertTrue(manualButtonExists, "Mode picker did now appear on screen.")
        
        manualButton.tap()
        
        let titleTextField = app.textFields["Title TextField"]
        let urlTextField = app.textFields["URL TextField"]
        
        XCTAssertTrue(titleTextField.exists, "The Title TextField doesn't exist.")
        XCTAssertTrue(urlTextField.exists, "The URL TextField doesn't exist.")
        
        titleTextField.tap()
        titleTextField.typeText("How to write UI tests in Swift")
        
        urlTextField.tap()
        urlTextField.typeText("https://example.com/ui-tests")
        
        let saveButton = app.buttons["Save manually created asset"]
        
        dismissKeyboardIfPresent(app: app)
        scrollToElement(saveButton, in: app)
        
        XCTAssertTrue(saveButton.exists, "The 'Save' button doesn't exist.")
        XCTAssertTrue(saveButton.isEnabled, "The 'Save' button should be enabled")
    }
}
