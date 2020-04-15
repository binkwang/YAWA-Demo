//
//  WeatherRouter.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import UIKit
import Foundation

protocol WeatherRoutingLogic {
    func navigateTo(dayWeather: Weather.DayWeatherViewModel)
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get }
}

class WeatherRouter: WeatherRoutingLogic, WeatherDataPassing {
    weak var viewController: WeatherViewController?
    
    // MARK: WeatherDataPassing
    var dataStore: WeatherDataStore? // TODO: use dataStore instead of the parameter in navigateTo function
    
    // MARK: Routing
    func navigateTo(dayWeather: Weather.DayWeatherViewModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        vc.dayWeather = dayWeather
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
