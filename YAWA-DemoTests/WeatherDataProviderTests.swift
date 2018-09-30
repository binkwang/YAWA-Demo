//
//  WeatherDataProviderTests.swift
//  YAWA-DemoTests
//
//  Created by Bink Wang on 30/09/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import XCTest
@testable import YAWA_Demo

class WeatherDataProviderTests: XCTestCase {
    
    func testWeatherDataProviderHasOWMResponse() {
        let dataProvider = WeatherDataProvider()
        
        XCTAssertNotNil(dataProvider.dayWeather, "dataProvider should have the porperty dayWeather")
    }
    
    
}
