//
//  YAWA_DemoUITests.swift
//  YAWA-DemoUITests
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import XCTest

@testable import YAWA_Demo
import OHHTTPStubs

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
        OHHTTPStubs.removeAllStubs()
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
        
        var textField = app.textFields["city name.."]
        textField.tap()
        textField.typeText("auckland")
        textField = app.textFields["auckland"] // find text filed according to value
        
//        let button = app.buttons["fetch"]
//        XCTAssertTrue(button.exists, "Button does not exist.")
//        button.tap() // failed with multi-match
        
        // TODO: Stub not triggered
        let jsonResponse = getJSON(from: "weather")
        stub(condition: isHost("api.openweathermap.org")) { _ in
            return OHHTTPStubsResponse(jsonObject: jsonResponse, statusCode: 200, headers: nil)
        }
        
        let accordianButtonsQuery = self.app.buttons.matching(identifier: "fetch")
        if accordianButtonsQuery.count > 0 {
            let firstButton = accordianButtonsQuery.element(boundBy: 0)
            firstButton.tap()
            
            let weatherLabel = app.staticTexts["overcast clouds"] // "sky is clear"
            
            // TOD: Failed to find "overcast clouds" StaticText after 5 seconds.
            waitForElementToAppear(element: weatherLabel)
        }
    }
}

extension XCTestCase {
    func getJSON(from jsonFile: String) -> [AnyHashable: Any] {
        guard let dict = try? Bundle(for: type(of: self)).getJSONDictionary(from: jsonFile) else {
            XCTFail("Resource not found or invalid: \(jsonFile).json")
            return [:]
        }
        
        return dict
    }
    
    func waitForElementToAppear(element: XCUIElement, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)

        waitForExpectations(timeout: 5) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after 5 seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
            }
        }
    }
}

extension Bundle {
    func getJSONData(from jsonFile: String) throws -> Data {
        return try getData(from: jsonFile, with: "json")
    }
    
    func getXMLData(from xmlFile: String) throws -> Data {
        return try getData(from: xmlFile, with: "xml")
    }
    
    func getData(from filePath: String, with fileExtension: String) throws -> Data {
        guard let url = self.url(forResource: filePath, withExtension: fileExtension) else {
            throw NSError(domain: NSURLErrorDomain, code: NSNotFound, userInfo: nil)
        }
    
        return try Data(contentsOf: url, options: .mappedIfSafe)
    }
    
    func getJSONDictionary(from jsonFile: String) throws -> [AnyHashable: Any] {
        let data = try getJSONData(from: jsonFile)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return json as? [AnyHashable: Any] ?? [:]
    }
    
    func getJSONArray(from jsonFile: String) throws -> [Any] {
        let data = try getJSONData(from: jsonFile)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return json as? [Any] ?? []
    }
}

