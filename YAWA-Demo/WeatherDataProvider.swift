//
//  WeatherDataProvider.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 30/09/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataProvider: NSObject, UITableViewDataSource {
    
    var dayWeather = [OWMResponse.DayWeather]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kWeatherTableViewCellReuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        cell.dayWeather = self.dayWeather[indexPath.row]
        
        return cell
    }
    
    func fetchWeathers(cityName: String?,
                       requestStart: @escaping () -> Void,
                       requestEnd: @escaping () -> Void,
                       success: @escaping (_ city: OWMResponse.City) -> Void,
                       failure: @escaping (_ errMessage: String) -> Void) {
            
        guard let cityName = cityName, !(cityName.isEmpty) else {
            failure("Please input an invalid city name")
            return
        }
        
        requestStart()
        RemoteDataRequestCenter.shared.fetchWeathers(cityName: cityName) { [weak self] (data, response, error) in
            guard let weakSelf = self else { return }
            requestEnd()
            
            if let data = data {
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let owmResponse = try jsonDecoder.decode(OWMResponse.self, from: data)
                        
                        if let cityObject = owmResponse.city, let list = owmResponse.list {
                            list.forEach({ (dayWeather) in
                                weakSelf.dayWeather.append(dayWeather)
                            })
                            success(cityObject)
                        } else {
                            failure("Error Occered")
                        }
                    } catch let error {
                        failure(error.localizedDescription)
                    }
                }
            } else if let error = error {
                failure(error.localizedDescription)
            }
        }
    }            
}



