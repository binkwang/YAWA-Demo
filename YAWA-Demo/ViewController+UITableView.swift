//
//  ViewController+UITableView.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 9/1/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate
{
    // UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.section as Any)
        print(indexPath.row as Any)
        
        let cell = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: "showWeatherDetailPage", sender: cell)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = WeatherTableViewHeader.init(frame: CGRect.init())
        headView.fetchHandler = { (city) in
            self.fetchWeathers(city: city, completion: {
                DispatchQueue.main.async() {
                    self.tableView.reloadData()
                    headView.cityLabel.text = self.city?.name
                    headView.textField.text = ""
                    headView.textField.resignFirstResponder()
                }
            })
        }
        return headView
    }
    
    // UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherConditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kWeatherTableViewCellReuseIdentifier, for: indexPath) as? WeatherTableViewCell else {
            fatalError("The dequeued cell is not an instance of SelectedPlaceCell.")
        }
        cell.weatherCondition = self.weatherConditions[indexPath.row]
        
        return cell
    }
}
