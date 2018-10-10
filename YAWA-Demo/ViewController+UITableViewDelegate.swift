//
//  ViewController+UITableView.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 9/1/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate
{
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
        
        headView.fetchHandler = { (cityName) in
            self.dataProvider.fetchWeathers(cityName: cityName, requestStart: {
                DispatchQueue.main.async() {
                    // TODO: show alert
                }
            }, requestEnd: {
                DispatchQueue.main.async() {
                    // TODO: dismiss alert
                }
            }, success: { [weak self] (cityObject) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async() {
                    strongSelf.cityObject = cityObject
                    strongSelf.tableView.reloadData()
                    headView.cityLabel.text = strongSelf.cityObject?.name
                    headView.textField.text = ""
                    headView.textField.resignFirstResponder()
                }
            }, failure: { [weak self] (errMessage) in
                guard let strongSelf = self else { return }
                DispatchQueue.main.async() {
                    strongSelf.showAlert("ERROR", "Please input an invalid city name")
                }
            })            
        }
        return headView
    }
}
