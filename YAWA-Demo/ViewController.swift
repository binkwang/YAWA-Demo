//
//  ViewController.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dataProvider = WeatherDataProvider()
    
    var cityObject: OWMResponse.City?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "WEATHER"
        
        // Init TableView
        tableView.delegate = self
        tableView.dataSource = dataProvider
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
        
        if segue.identifier == "showWeatherDetailPage"  {
            let indexPath: NSIndexPath = self.tableView.indexPath(for: sender as! WeatherTableViewCell)! as NSIndexPath
            if let destinationViewController = segue.destination as? WeatherDetailViewController {
                destinationViewController.dayWeather = (self.dataProvider.dayWeather)[indexPath.row]
                destinationViewController.cityName = self.cityObject?.name
            }
        }
    }
}
