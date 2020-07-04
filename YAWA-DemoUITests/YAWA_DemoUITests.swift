//
//  YAWA_DemoUITests.swift
//  YAWA-DemoUITests
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import YAWA_Demo

class YAWA_DemoUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        // UI tests must launch the application that they test.
        // Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testExample() {
        app.launch()

        EarlGrey
        .selectElement(with: grey_keyWindow())
        .perform(grey_tap())
    }
    
    func testPageHasCorrectTitle() {
        app.launch()
        
        let navigationBar = app.navigationBars.staticTexts["WEATHER"]
        
        XCTAssertTrue(navigationBar.exists, "Title is not correct.")
    }
    
    func testFetchButtonExists() {
        app.launch()
        
        let button = app.buttons["fetch"]
        
        XCTAssertTrue(button.exists, "Button does not exist.")
    }
    
    func testTextFieldExists() {
        app.launch()
        
        let textField = app.textFields["city name.."] // place holder text
        
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
        
        // TODO: Cannot stub network reqeust making from main applicaiton
        // https://github.com/AliSoftware/OHHTTPStubs/issues/124
        let jsonResponse = getJSON(from: "weather")
        stub(condition: isScheme("http") && isHost("api.openweathermap.org")) { _ in
            return OHHTTPStubsResponse(jsonObject: jsonResponse, statusCode: 200, headers: nil)
        }
        
        let buttonsQuery = app.buttons.matching(identifier: "fetch")
        if buttonsQuery.count > 0 {
            let firstButton = buttonsQuery.element(boundBy: 0)
            firstButton.tap()
            
            let weatherLabel = app.staticTexts["description: scattered clouds"] // "sky is clear", "overcast clouds"
            
            waitForElementToAppear(element: weatherLabel)
        }
    }
    
    func testSessionDataTaskCanBeStubbedByOHHTTPStubs() {
        app.launch()
        
        let tempExpectation = expectation(description: "temporary expectation")
        
        let jsonResponse = getJSON(from: "weather")
        stub(condition: isHost("a_random_host")) { _ in
            return OHHTTPStubsResponse(jsonObject: jsonResponse, statusCode: 200, headers: nil)
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: URL(string: "https://a_random_host/login")!) { (data, response, error) in
            print("data------------: \(String(describing: data))")
            
            tempExpectation.fulfill()
        }.resume()
        
        waitForExpectations(timeout: 5.0, handler: nil)
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

