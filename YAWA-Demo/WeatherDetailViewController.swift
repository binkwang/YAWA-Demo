//
//  WeatherDetailViewController.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var weatherCondition: WeatherCondition?
    var city: String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "DETAIL"

        // Init TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        tableView.separatorColor = UIColor.gray
        let nib = UINib.init(nibName: "DetailPageCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: kDetailPageCellReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    // UITableViewDataSource
    
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
            if let date = weatherCondition?.datePrintFormat {
                cell.labelText = String(describing:"date: \(date)")
            }
        case 2:
            if let main = weatherCondition?.weathers[0].main {
                cell.labelText = String(describing:"main weather: \(main)")
            }
        case 3:
            if let icon = weatherCondition?.weathers[0].icon {
                cell.labelText = String(describing:"weather icon (code:\(icon)): ")
                cell.weatherCode = icon
            }
        case 4:
            if let description = weatherCondition?.weathers[0].description {
                cell.labelText = String(describing:"description: \(description)")
            }
        case 5:
            if let min = weatherCondition?.temp?.min {
                cell.labelText = String(describing:"min temp: \(min)")
            }
        case 6:
            if let max = weatherCondition?.temp?.max {
                cell.labelText = String(describing:"max temp: \(max)")
            }
        default:
            cell.labelText = ""
        }
        
        return cell
    }

}
