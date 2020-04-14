//
//  WeatherRouter.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import UIKit
import Foundation

//@objc
protocol WeatherRoutingLogic {
    func navigateTo(dayWeather: Weather.DayWeatherViewModel)
}

class WeatherRouter: WeatherRoutingLogic {
    weak var viewController: WeatherViewController?
    
    // MARK: Routing
    func navigateTo(dayWeather: Weather.DayWeatherViewModel) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        vc.dayWeather = dayWeather
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
