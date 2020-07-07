//
//  WeatherRepoDecorator.swift
//  YAWA-Demo
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

protocol WeatherRepoDecorator: WeatherRepo {
    var inner: WeatherRepo { get }
}

extension WeatherRepoDecorator {
    func fetchWeathers(cityName: String?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        inner.fetchWeathers(cityName: cityName, completion: completion)
    }
}
