//
//  WeatherRepoCacheDecorator.swift
//  YAWA-Demo
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

class WeatherRepoCacheDecorator: WeatherRepoDecorator {
    var inner: WeatherRepo
    var cache: WeatherCache
    
    init(inner: WeatherRepo, cache: WeatherCache) {
        self.inner = inner
        self.cache = cache
    }
    
    func fetchWeathers(cityName: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let cityName = cityName else { return }
        
        guard let data = cache.getWeather(city: cityName) else {
            
            return inner.fetchWeathers(cityName: cityName) { [weak self] (data, response, error) in
                
                if let self = self, let data = data {
                    self.cache.storeWeather(city: cityName, weather: data)
                }
                
                completion(data, response, error)
            }
        }
        completion(data, nil, nil)
    }
}
