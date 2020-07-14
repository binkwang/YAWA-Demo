//
//  WeatherWorkerTest.swift
//  YAWA-DemoTests
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import XCTest
@testable import YAWA_Demo

class WeatherWorkerTest: XCTestCase {
    
    // MARK: Subject Under Test
    
    let sut = WeatherWorker()
    
    // MARK: Test Case Life Cycle
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test Doubles
    
    class WeatherCacheMock: WeatherCache {
        var mockData: WeatherResponse? = nil
        
        var getWeatherMethodCalled = false
        var storeWeatherMethodCalled = false
        
        func getWeather(city: String) -> WeatherResponse? {
            getWeatherMethodCalled = true
            return mockData
        }
        
        func storeWeather(city: String, weather: WeatherResponse) {
            storeWeatherMethodCalled = true
        }
    }
    
    class WeatherRepoMock: WeatherRepo {
        var mockData: WeatherResponse? = nil
        var fetchWeathersMethodCalled = false
        
        func fetchWeathers(cityName: String?,
                           completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
            fetchWeathersMethodCalled = true
            
            guard let mockData = mockData else {
                XCTFail("mock data should not be nil")
                return
            }
            completion(.success(mockData))
        }
    }
    
    // MARK: Test Cases
    
    func testFetchWethersWithCache() {
        
        // Given
        
        let weatherCache = WeatherCacheMock()
        weatherCache.mockData = getObject()
        let web = WeatherRepoMock()
        let weatherRepo = WeatherRepoCacheDecorator(inner: web, cache: weatherCache)
        
        sut.weatherRepo = weatherRepo
        
        // When
        
        let expect = expectation(description: "returns mutiple menu ids")
        
        let requestStart = { DispatchQueue.main.async() {} }
        let requestEnd = { DispatchQueue.main.async() {} }
        let failure: (String) -> Void = { (errMessage) in
            DispatchQueue.main.async() {}
        }
        
        sut.fetchWeathers(cityName: "",
                          requestStart: requestStart,
                          requestEnd: requestEnd,
                          success: { response in
                            
                            // Thens
                            XCTAssertTrue(weatherCache.getWeatherMethodCalled)
                            XCTAssertFalse(web.fetchWeathersMethodCalled)
                            
                            XCTAssertNotNil(response.weather)
                            XCTAssertEqual(response.weather.cod, "200")
                            
                            expect.fulfill()
                            
        }, failure: failure)
        
        waitForExpectations(timeout: 1)
    }
    
    func testFetchWethersWithWeb() {
        
        // Given
        
        let weatherCache = WeatherCacheMock()
        let web = WeatherRepoMock()
        web.mockData = getObject()
        let weatherRepo = WeatherRepoCacheDecorator(inner: web, cache: weatherCache)
        
        sut.weatherRepo = weatherRepo
        
        // When
        
        let expect = expectation(description: "returns mutiple menu ids")
        
        let requestStart = { DispatchQueue.main.async() {} }
        let requestEnd = { DispatchQueue.main.async() {} }
        let failure: (String) -> Void = { (errMessage) in
            DispatchQueue.main.async() {}
        }
        
        sut.fetchWeathers(cityName: "",
                          requestStart: requestStart,
                          requestEnd: requestEnd,
                          success: { response in
                            
                            // Thens
                            XCTAssertTrue(weatherCache.getWeatherMethodCalled)
                            XCTAssertTrue(weatherCache.storeWeatherMethodCalled)
                            XCTAssertTrue(web.fetchWeathersMethodCalled)
                            
                            XCTAssertNotNil(response.weather)
                            XCTAssertEqual(response.weather.cod, "200")
                            
                            expect.fulfill()
                            
        }, failure: failure)
        
        waitForExpectations(timeout: 1)
    }
}

extension XCTestCase {
    
    func getObject() -> WeatherResponse? {
        let jsonDecoder = JSONDecoder()
        
        guard let data = getData(from: "weather") else {
            return nil
        }
        
        guard let object = try? jsonDecoder.decode(WeatherResponse.self, from: data) else {
            return nil
        }
        
        return object
    }
    
    func getData(from jsonFile: String) -> Data? {
        guard let data = try? Bundle(for: type(of: self)).getJSONData(from: jsonFile) else {
            XCTFail("Resource not found or invalid: \(jsonFile).json")
            return nil
        }
        return data
    }
}
