//
//  TheWeatherCache.swift
//  YAWA-Demo
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

class TheWeatherCache: WeatherCache {
    
    private var weathers: [String: WeatherResponse] = [:]
    
    func getWeather(city: String) -> WeatherResponse? {
        return weathers[city]
    }
    func storeWeather(city: String, weather: WeatherResponse) {
        weathers[city] = weather
    }
}
