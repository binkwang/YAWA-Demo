//
//  ViewController.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dayWeather: [OWMResponse.DayWeather] = [] {
        didSet {
        }
    }
    var city: OWMResponse.City?
    
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
                destinationViewController.dayWeather = (self.dayWeather)[indexPath.row]
                destinationViewController.city = self.city?.name
            }
        }
    }
    
    func fetchWeathers(city: String?, completion: @escaping () -> Swift.Void) -> Swift.Void {
        
        guard let city = city, !(city.isEmpty) else {
            showAlert("ERROR", "Please input an invalid city name")
            return
        }
        
        let spinner = UIViewController.displaySpinner(onView: self.view)
        
        RemoteDataRequestCenter.shared.fetchWeathers(city: city) { [weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            
            UIViewController.removeSpinner(spinner: spinner)
            
            if let data = data {
                
                DispatchQueue.global(qos: .utility).async {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let owmResponse = try jsonDecoder.decode(OWMResponse.self, from: data)
                        
                        if let city = owmResponse.city, let list = owmResponse.list {
                            DispatchQueue.main.async {
                                strongSelf.city = city
                                list.forEach({ (dayWeather) in
                                    strongSelf.dayWeather.append(dayWeather)
                                })
                                completion()
                            }
                        } else {
                            DispatchQueue.main.async {
                                strongSelf.showAlert("ERROR", "Error Occered")
                            }
                        }

                    } catch let error {
                        DispatchQueue.main.async {
                            strongSelf.showAlert("ERROR", error.localizedDescription)
                        }
                    }
                }
            } else if let error = error {
                print(error)
                strongSelf.showAlert("ERROR", "Error Occered")
            }
        }
    }
}

