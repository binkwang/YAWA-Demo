//
//  WebWeatherRepo.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class WebWeatherRepo: ApiService, WeatherRepo {
    override init() { super.init() }
    
    func fetchWeathers(cityName: String?,
                       completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        
        guard let cityName = cityName else { return }
        
        do {
            let request = try WeatherApi.getWeather(city: cityName).request()
            
            callApi(request: request, modelType: WeatherResponse.self) { (result) in
                completion(result)
            }
        } catch {
            completion(.failure(error))
        }
    }
}
