//
//  WeatherInteractor.swift
//  YAWA-Demo
//
//  Created by bink.wang on 12/04/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

protocol WeatherBusinessLogic {
    func loadWeatherList(request: Weather.LoadWeatherList.Request)
    func selectDayWeather(request: Weather.SelectDayWeather.Request)
}

protocol WeatherDataStore {
    var selectedDayWeather: WeatherResponse.DayWeather? { get set }
}

class WeatherInteractor: WeatherBusinessLogic, WeatherDataStore {

    // MARK: Clean Swift

    var presenter: WeatherPresentationLogic?
    var worker: WeatherWorker?
    
    // MARK: Data
    var weatherResponse: WeatherResponse?
    
    // MARK: WeatherDataStore
    var selectedDayWeather: WeatherResponse.DayWeather?
    
    
    // MARK: Load OpenAndApply list
    
    func loadWeatherList(request: Weather.LoadWeatherList.Request) {
        
        worker?.fetchWeathers(cityName: request.cityName, requestStart: {
            DispatchQueue.main.async() {
                // TODO: show alert
            }
        }, requestEnd: {
            DispatchQueue.main.async() {
                // TODO: dismiss alert
            }
        }, success: { [weak self] (response) in
            DispatchQueue.main.async() {
                guard let strongSelf = self else { return }
                strongSelf.weatherResponse = response.weather
                strongSelf.presenter?.presentWeatherList(response: response)
            }
        }, failure: { (errMessage) in
            DispatchQueue.main.async() {
                // TODO: dismiss alert
            }
        })
    }
    
    func selectDayWeather(request: Weather.SelectDayWeather.Request) {
        guard let dayWeather = weatherResponse?.list?[request.index] else { return }
        selectedDayWeather = dayWeather
        presenter?.presetnWeatherDetail(response: Weather.SelectDayWeather.Response(dayWeather: dayWeather))
    }
}
