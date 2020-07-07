//
//  TheWeatherCache.swift
//  YAWA-Demo
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

class TheWeatherCache: WeatherCache {
    
    private var weathers: [String: Data] = [:]
    
    func getWeather(city: String) -> Data? {
        return weathers[city]
    }
    
    func storeWeather(city: String, weather: Data) {
        weathers[city] = weather
    }
}
