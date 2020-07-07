//
//  WeatherModels.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

enum Weather {
    
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
