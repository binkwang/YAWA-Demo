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
    
    var remoteDataRequestCenter: RemoteDataRequestCenter = RemoteDataRequestCenter()
    
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
        
        remoteDataRequestCenter.fetchWeathers(city: city) { (data, response, error) in
            DispatchQueue.main.async() {
                UIViewController.removeSpinner(spinner: spinner)
            }
            
            if let data = data {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    
                    if let json = jsonSerialized {
                        
                        let invalidAPIKeyError = InvalidAPIKeyError.init(with: json)
                        if let cod = invalidAPIKeyError.cod, cod==401 {
                            self.showAlert("ERROR", "Invalid API key")
                        }
                        
                        let cityWeathers = CityWeathers.init(with: json)
                        self.city = cityWeathers.city
                        
                        self.weatherConditions.removeAll()
                        cityWeathers.weatherConditions.forEach({ (weatherCondition) in
                            self.weatherConditions.append(weatherCondition)
                        })
                        
                        print(cityWeathers.city?.name as Any)
                        
                        completion()
                    }
                    
                } catch let error as NSError {
                    print(error)
                    self.showAlert("ERROR", "Error Occered")
                }
            } else if let error = error {
                print(error)
                self.showAlert("ERROR", "Error Occered")
            }
        }
    }
    
    // MARK: private methods

    private func showAlert(_ title: String, _ message: String) {
        DispatchQueue.main.async() {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: UITableViewDataSource & UITableViewDelegate

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

extension UIViewController {
    class func displaySpinner(onView: UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner: UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

