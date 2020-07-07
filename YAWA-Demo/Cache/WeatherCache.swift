//
//  WeatherCache.swift
//  YAWA-Demo
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

protocol WeatherCache {
    func getWeather(city: String) -> Data?
    func storeWeather(city: String, weather: Data)
}
