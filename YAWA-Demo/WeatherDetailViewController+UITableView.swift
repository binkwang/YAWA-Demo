//
//  WeatherDetailViewController+UITableView.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 9/1/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

extension WeatherDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kDetailPageCellReuseIdentifier, for: indexPath) as? DetailPageCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        
        switch indexPath.row {
        case 0:
            if let city = city {
                cell.labelText = String(describing:"city: \(city)")
            }
        case 1:
            if let dt = dayWeather?.dt {
                cell.labelText = Date.printFormat(dt: dt)
            }
        case 2:
            if let main = dayWeather?.weather?[0].main {
                cell.labelText = String(describing:"main weather: \(main)")
            }
        case 3:
            if let icon = dayWeather?.weather?[0].icon {
                cell.labelText = String(describing:"weather icon (code:\(icon)): ")
                cell.weatherCode = icon
            }
        case 4:
            if let description = dayWeather?.weather?[0].description {
                cell.labelText = String(describing:"description: \(description)")
            }
        case 5:
            if let min = dayWeather?.temp?.min {
                cell.labelText = String(describing:"min temp: \(min)")
            }
        case 6:
            if let max = dayWeather?.temp?.max {
                cell.labelText = String(describing:"max temp: \(max)")
            }
        default:
            cell.labelText = ""
        }
        
        return cell
    }
}
