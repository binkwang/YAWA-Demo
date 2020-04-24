//
//  YAWA_DemoUITests.swift
//  YAWA-DemoUITests
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import XCTest

class YAWA_DemoUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPageHasCorrectTitle() {
        app.launch()
        
        let navigationBar = app.navigationBars.staticTexts["WEATHER"]
        
        XCTAssertTrue(navigationBar.exists, "Title is not correct.") //check navigation bar title
    }
    
    func testFetchButtonExists() {
        app.launch()
        
        let button = app.buttons["fetch"]
        
        XCTAssertTrue(button.exists, "Button does not exist.")
    }
    
    func testTextFieldExists() {
        app.launch()
        
        let textField = app.textFields["city name.."] // find text filed according to place holder
        
        XCTAssertTrue(textField.exists, "Text field does not exist.")
    }
    
    func testTextFieldTypeCorrectText() {
        app.launch()
        
        var textField = app.textFields["city name.."]
        textField.tap()
        textField.typeText("auckland")
        textField = app.textFields["auckland"] // find text filed according to value
        
        XCTAssertEqual(textField.value as! String, "auckland", "Text field value is not correct.")
    }
    
    func testButtonTap() {
        app.launch()
    }
}
