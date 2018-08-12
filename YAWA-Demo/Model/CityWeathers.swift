//
//  CityWeathers.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

struct CityWeathers {
    var city: City?
    var weatherConditions: [WeatherCondition] = []
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        city = City.init(with: dictionary["city"] as? [String: Any])
        
        if let weatherContitionArr = dictionary["list"] as? [[String: Any]] {
            weatherContitionArr.forEach { (weatherContitionDic) in
                let weatherCondition = WeatherCondition.init(with: weatherContitionDic)
                self.weatherConditions.append(weatherCondition)
            }
        }
    }
}

/** Json example
{
    city: {
        id: 2643743,
        name: "London",
        coord: {
            lon: -0.1277,
            lat: 51.5073
        },
        country: "GB",
        population: 1000000
    },
    cod: "200",
    message: 8.0072426,
    cnt: 2,
    list: [
    {
    dt: 1533988800,
    temp: {
    day: 18.84,
    min: 7.98,
    max: 18.84,
    night: 16.94,
    eve: 17.92,
    morn: 7.98
    },
    pressure: 1028.46,
    humidity: 0,
    weather: [
    {
    id: 800,
    main: "Clear",
    description: "sky is clear",
    icon: "01d"
    }
    ],
    speed: 3.97,
    deg: 193,
    clouds: 27
    },
    {
    dt: 1534075200,
    temp: {
    day: 17.59,
    min: 15.35,
    max: 18.68,
    night: 15.35,
    eve: 18.68,
    morn: 15.76
    },
    pressure: 1014.61,
    humidity: 92,
    weather: [
    {
    id: 501,
    main: "Rain",
    description: "moderate rain",
    icon: "10d"
    }
    ],
    speed: 5.41,
    deg: 196,
    clouds: 92,
    rain: 8.22
    }
    ]
}
**/

