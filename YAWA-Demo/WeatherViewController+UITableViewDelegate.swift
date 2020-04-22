//
//  WetherViewController+UITableView.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 9/1/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section as Any)
        print(indexPath.row as Any)
        
        self.selectDayWeather(index: indexPath.row)
    }
    

//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = WeatherTableViewHeader.init(frame: CGRect.init())
        headView.delegate = self
        return headView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dayWeathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: kWeatherTableViewCellReuseIdentifier) as? WeatherTableViewCell ?? initWeatherCellCell() else {
//            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kWeatherTableViewCellReuseIdentifier) as? WeatherTableViewCell ?? initWeatherCellCell()
        
        let dayWeather = self.dayWeathers[indexPath.row]
        
        cell.updateContents(topText: dayWeather.date,
                            middleText: dayWeather.temperature,
                            bottomText: dayWeather.description)
        return cell
    }
    
    private func initWeatherCellCell() -> WeatherTableViewCell {
        return WeatherTableViewCell(reuseIdentifier: kWeatherTableViewCellReuseIdentifier)
    }
}

extension WeatherViewController: WeatherTableHeaderActionProtocol {
    func onButtonTapped(text: String?) {
        guard let cityName = text else { return }
        self.loadWeather(cityName: cityName)
    }
}
