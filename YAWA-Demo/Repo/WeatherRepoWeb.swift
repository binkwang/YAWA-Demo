//
//  WebWeatherRepo.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class WebWeatherRepo: WeatherRepo {
    
    init() {}
    
    func fetchWeathers(cityName: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let cityName = cityName else { return }
        
        do {
            let request = try WeatherApi.getWeather(city: cityName).request()
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                completion(data, response, error)
            }).resume()
            
        } catch {
            completion(nil, nil, error)
        }
    }
    
}
