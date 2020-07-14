//
//  WeatherRepo.swift
//  YAWA-Demo
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

protocol WeatherRepo {
    func fetchWeathers(cityName: String?,
                       completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}
