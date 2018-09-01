//
//  WeatherCondition.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation


class WeatherCondition {
    var temp: Temp?
    var weathers: [Weather] = []
    var pressure: Double?
    var speed: Double?
    var deg: Double?
    var clouds: Double?
    var dt: Double?
    var datePrintFormat: String?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        pressure = dictionary["pressure"] as? Double
        speed = dictionary["speed"] as? Double
        deg = dictionary["deg"] as? Double
        clouds = dictionary["clouds"] as? Double
        dt = dictionary["dt"] as? Double
        
        temp = Temp.init(with: dictionary["temp"] as? [String: Any])
        
        if let weatherArr = dictionary["weather"] as? [[String: Any]] {
            weatherArr.forEach { (weatherDic) in
                let weather = Weather.init(with: weatherDic)
                self.weathers.append(weather)
            }
        }
        
        if let dt = dt {
            let date = Date(timeIntervalSince1970: dt)
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
            datePrintFormat = dateFormatterPrint.string(from: date)
            //print(dateFormatterPrint.string(from: date))
        }
        
    }
}

/** Json example
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
}
**/

 
