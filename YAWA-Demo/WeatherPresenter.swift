//
//  WeatherPresenter.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

protocol WeatherPresentationLogic {
    func presentWeatherList(response: Weather.LoadWeatherList.Response)
    func presetnWeatherDetail(response: Weather.SelectDayWeather.Response)
}

class WeatherPresenter: WeatherPresentationLogic {
    weak var viewController: WeatherViewController?
    
    // MARK: Present open and apply list
    func presentWeatherList(response: Weather.LoadWeatherList.Response) {
        
        var viewModel =  Weather.LoadWeatherList.ViewModel()
        
        guard let dayWeathers = response.weather.list else { return }
        
        for dayWeather in dayWeathers {
            
            guard let date = dayWeather.dt,
                let temperature = dayWeather.temp?.day,
                let description = dayWeather.weather?[0].description else { break }
            
            let obj = Weather.DayWeatherViewModel(
                date: Date.printFormat(dt: date),
                temperature: String(describing:"day temp: \(temperature)"),
                description: String(describing:"description: \(description)")
            )
            
            viewModel.dayWeathers.append(obj)
        }
        
        viewController?.displayWeatherList(viewModel: viewModel)
    }
    
    func presetnWeatherDetail(response: Weather.SelectDayWeather.Response) {
        
        let dayWeather = response.dayWeather
        
        guard let date = dayWeather.dt,
            let temperature = dayWeather.temp?.day,
            let description = dayWeather.weather?[0].description else { return }
        
        let viewModel = Weather.DayWeatherViewModel(
            date: Date.printFormat(dt: date),
            temperature: String(describing:"day temp: \(temperature)"),
            description: String(describing:"description: \(description)")
        )
        
        viewController?.displayWeatherDetail(viewModel: Weather.SelectDayWeather.ViewModel(dayWeather: viewModel))
    }
}

