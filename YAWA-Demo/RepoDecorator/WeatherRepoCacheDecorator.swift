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
    
    func fetchWeathers(cityName: String?,
                       completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard let cityName = cityName else { return }
        guard let weatherResposne = cache.getWeather(city: cityName) else {
            
            return inner.fetchWeathers(cityName: cityName) { [weak self] (result) in
                guard let self = self else { return }
                
                switch result {
                case .success(let weatherResposne):
                    self.cache.storeWeather(city: cityName, weather: weatherResposne)
                case .failure:
                    print("")
                }
                
                completion(result)
            }
        }
        completion(.success(weatherResposne))
    }
}
