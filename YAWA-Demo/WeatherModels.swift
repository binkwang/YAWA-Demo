//
//  WeatherModels.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

enum Weather {
    
    // MARK: Weather List
    enum LoadWeatherList {
        struct Request {
            var cityName: String
        }
        
        struct Response {
            var weather: WeatherResponse
        }
        
        struct ViewModel {
            var dayWeathers = [DayWeatherViewModel]()
        }
    }
    
    enum SelectDayWeather {
        struct Request {
            var index: Int
        }
        
        struct Response {
            var dayWeather: WeatherResponse.DayWeather
        }
        
        struct ViewModel {
            var dayWeather: DayWeatherViewModel
        }
    }
    
    struct DayWeatherViewModel {
        var date: String
        var temperature: String
        var description: String
    }
}

struct WeatherResponse: Decodable {
    
    // MARK: - Properties
    
    public let cod: String
    public let message: Double
    public let cnt: Int
    public let list: [DayWeather]?
    public let city: City?
    
    // MARK: - Types
    
    struct DayWeather: Decodable {
        public let dt: Double?
        public let pressure: Double?
        public let humidity: Int?
        public let speed: Double?
        public let temp: Temp?
        public let weather: [Weather]?
        
        struct Temp: Decodable {
            var day: Double?
            var min: Double?
            var max: Double?
            var night: Double?
            var eve: Double?
            var morn: Double?
        }
        
        struct Weather: Decodable {
            var id: Int?
            var main: String?
            var description: String?
            var icon: String?
        }
    }
    
    struct City: Decodable {
        var id: Int
        var name: String
        var country: String
        var population: Int
    }
}

/**
{
    city: {
        id: 1816670,
        name: "Beijing",
        coord: {
            lon: 116.3912,
            lat: 39.906
        },
        country: "CN",
        population: 1000000
    },
    cod: "200",
    message: 0.7302709,
    cnt: 2,
    list: [
    {
    dt: 1536120000,
    temp: {
    day: 33,
    min: 20.93,
    max: 33,
    night: 20.93,
    eve: 30.98,
    morn: 33
    },
    pressure: 992.11,
    humidity: 43,
    weather: [
    {
    id: 800,
    main: "Clear",
    description: "sky is clear",
    icon: "01d"
    }
    ],
    speed: 2.58,
    deg: 216,
    clouds: 0
    },
    {}
    ]
}
 */
