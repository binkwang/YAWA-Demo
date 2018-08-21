//
//  RemoteDataRequestCenter.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class RemoteDataRequestCenter {
    
    static let shared = RemoteDataRequestCenter()
    
    private init() {}
    
    func fetchWeathers(city: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        
        guard let city = city, !(city.isEmpty) else { return }
        
        // url. An example: http://api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=json&units=metric&cnt=7&appid=542ffd081e67f4512b705f89d2a611b2
        let url = "\(String(describing: WeatherEndpoint))q=\(String(describing: city))&mode=json&units=metric&cnt=7&appid=\(OWMAPIKey)"
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Cache-Control": "no-cache"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            completion(data, response, error)
        })
        dataTask.resume()
    }
    
    func getWeatherImage(code: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) {
        guard let code = code, !(code.isEmpty) else { return }
        
        // url. An example: http://openweathermap.org/img/w/10d.png
        let url = "\(String(describing: WeatherIconEndpoint))\(String(describing: code)).png"
        
        URLSession.shared.dataTask(with: NSURL(string: url)! as URL) { (data, response, error) -> Void in
            completion(data, response, error)
        }.resume()
    }
    
}
