//
//  ViewController.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var weatherConditions: [WeatherCondition] = [] {
        didSet {
        }
    }
    var city: City?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "WEATHER"
        
        // Init TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor.gray
        let nib = UINib.init(nibName: "WeatherTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kWeatherTableViewCellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //the sender is the actual UITableViewCell. When you have the cell, there are a few ways to get the index path.

        if segue.identifier == "showWeatherDetailPage"  {
            let indexPath: NSIndexPath = self.tableView.indexPath(for: sender as! WeatherTableViewCell)! as NSIndexPath
            if let destinationViewController = segue.destination as? WeatherDetailViewController {
                destinationViewController.weatherCondition = (self.weatherConditions)[indexPath.row]
                destinationViewController.city = self.city?.name
            }
        }
    }
    
    func fetchWeathers(city: String?, completion: @escaping () -> Swift.Void) -> Swift.Void {
        
        guard let city = city, !(city.isEmpty) else {
            showAlert("ERROR", "Please input an invalid city name")
            return
        }
        print("fetchWeatherDataWithCity: \(city)")
        
        let spinner = UIViewController.displaySpinner(onView: self.view)
        
        RemoteDataRequestCenter.shared.fetchWeathers(city: city) { [weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            
            UIViewController.removeSpinner(spinner: spinner)
            
            if let data = data {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    
                    if let json = jsonSerialized {
                        
                        let invalidAPIKeyError = InvalidAPIKeyError.init(with: json)
                        if let cod = invalidAPIKeyError.cod, cod==401 {
                            strongSelf.showAlert("ERROR", "Invalid API key")
                        }
                        
                        let cityWeathers = CityWeathers.init(with: json)
                        strongSelf.city = cityWeathers.city
                        
                        strongSelf.weatherConditions.removeAll()
                        cityWeathers.weatherConditions.forEach({ (weatherCondition) in
                            strongSelf.weatherConditions.append(weatherCondition)
                        })
                        
                        print(cityWeathers.city?.name as Any)
                        
                        completion()
                    }
                    
                } catch let error as NSError {
                    print(error)
                    strongSelf.showAlert("ERROR", "Error Occered")
                }
            } else if let error = error {
                print(error)
                strongSelf.showAlert("ERROR", "Error Occered")
            }
        }
    }
}

