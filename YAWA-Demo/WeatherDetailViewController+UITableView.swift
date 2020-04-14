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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kDetailPageCellReuseIdentifier, for: indexPath) as? DetailPageCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        
        switch indexPath.row {
        case 0:
            cell.label.text = ""
        case 1:
            cell.label.text = dayWeather?.date
        case 2:
            cell.label.text = dayWeather?.temperature
        case 3:
            cell.label.text = dayWeather?.description
        default:
            cell.label.text = ""
        }
        
        return cell
    }
}
