//
//  WeatherWorker.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

class WeatherWorker {
    var weatherRepo: WeatherRepo

    init() {
        let cache = TheWeatherCache()
        let web = WebWeatherRepo()
        weatherRepo = WeatherRepoCacheDecorator(inner: web, cache: cache)
    }
    
    func fetchWeathers(cityName: String?,
                       requestStart: @escaping () -> Void,
                       requestEnd: @escaping () -> Void,
                       success: @escaping (_ response: Weather.LoadWeatherList.Response) -> Void,
                       failure: @escaping (_ errMessage: String) -> Void) {
        
        weatherRepo.fetchWeathers(cityName: cityName) { (result) in
            requestEnd()
            
            switch result {
            case .success(let weatherResponse):
                success(Weather.LoadWeatherList.Response(weather: weatherResponse))
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
