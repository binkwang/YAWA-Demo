//
//  WeatherApi.swift
//  YAWA-Demo
//
//  Created by bink.wang on 20/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

internal let OWMAPIKey = "542ffd081e67f4512b705f89d2a611b2"

enum WeatherApi {
    case getWeather(city: String)
    case getWeatherIcon(code: String)
    
    enum Constant: String {
        case weatherBaseUrl = "http://api.openweathermap.org/data/2.5/forecast/daily?"
        case weatherIconBaseUrl = "http://openweathermap.org/img/w/"
        case defaultContentType = "application/x-www-form-urlencoded"
        case contentTypeHeaderKey = "Content-Type"
    }
    
    /***************
     * Example:
     * http://api.openweathermap.org/data/2.5/forecast/daily?q=auckland&mode=json&units=metric&cnt=7&appid=542ffd081e67f4512b705f89d2a611b2
     * http://openweathermap.org/img/w/10d.png
     */
    private var full: String {
        switch self {
        case let .getWeather(city):
            return Constant.weatherBaseUrl.rawValue + "q=" + city + "&mode=json&units=metric&cnt=7&appid=" + OWMAPIKey
        case let .getWeatherIcon(code):
            return Constant.weatherIconBaseUrl.rawValue + code + ".png"
        }
    }
    
    private var method: HttpMethod {
        switch self {
        case .getWeather, .getWeatherIcon: return .get
        }
    }
    
    private var contentType: String {
        switch self {
        default: return Constant.defaultContentType.rawValue
        }
    }
    
    private var hasValidCity: Bool {
        switch self {
        case let .getWeather(city):
            return !city.isEmpty
        default:
            return true
        }
    }
    
    private var hasIconCode: Bool {
        switch self {
        case let .getWeatherIcon(code):
            return !code.isEmpty
        default:
            return true
        }
    }
    
    func request() throws -> URLRequest {
        guard hasValidCity else { throw  RequestError.invalidCity }
        guard let url = URL(string: full) else { throw RequestError.invalidUrl(url: full) }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(contentType, forHTTPHeaderField: Constant.contentTypeHeaderKey.rawValue)
        return request
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RequestError: Error {
    case invalidCity
    case invalidWeatherCode
    case invalidUrl(url: String)
}
