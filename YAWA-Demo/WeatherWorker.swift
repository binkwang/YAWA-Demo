//
//  WeatherWorker.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

class WeatherWorker {
    let weatherRepo: WeatherRepo

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
        
        requestStart()
        
        weatherRepo.fetchWeathers(cityName: cityName) { (data, _, error) in
            requestEnd()
            
            if let data = data {
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let weatherResponse = try jsonDecoder.decode(WeatherResponse.self, from: data)
                        
                        success(Weather.LoadWeatherList.Response(weather: weatherResponse))
                    } catch let error {
                        failure(error.localizedDescription)
                    }
                }
            } else if let error = error {
                failure(error.localizedDescription)
            }
        }
    }
}
