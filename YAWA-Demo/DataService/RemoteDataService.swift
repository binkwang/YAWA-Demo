//
//  RemoteDataService.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class RemoteDataService {
    
    static let shared = RemoteDataService()
    
    private init() {}
    
    func fetchWeathers(cityName: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        guard let cityName = cityName else { return }
        
        do {
            let request = try WeatherApi.getWeather(city: cityName).request()
            print("request host---------------: \(String(describing: request.url?.host))")
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                completion(data, response, error)
            }).resume()
            
        } catch {
            completion(nil, nil, error)
        }
    }
    
    func getWeatherImage(code: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        guard let code = code else { return }
        do {
            let request = try WeatherApi.getWeatherIcon(code: code).request()
            
            URLSession.shared.dataTask(with: request) { (data, response, error) -> Void in
                completion(data, response, error)
            }.resume()
        } catch {
            completion(nil, nil, error)
        }
    }
    
}
