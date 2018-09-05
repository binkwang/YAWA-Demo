//
//  WeatherTableViewCell.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kWeatherTableViewCellReuseIdentifier = "WeatherTableViewCell"

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var dayWeather: OWMResponse.DayWeather? {
        didSet {
            guard let dayWeather = dayWeather else { return }
            
            if let dt = dayWeather.dt {
                self.dateLabel.text = Date.printFormat(dt: dt)
            }
            if let temp = dayWeather.temp?.day {
                self.temperatureLabel.text = String(describing:"day temp: \(temp)")
            }
            if let description = dayWeather.weather?[0].description {
                self.descriptionLabel.text = String(describing:"description: \(description)")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dateLabel.backgroundColor = UIColor.clear
        temperatureLabel.backgroundColor = UIColor.clear
        descriptionLabel.backgroundColor = UIColor.clear
        
        self.viewAutoLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func viewAutoLayout() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        let views = Dictionary(dictionaryLiteral: ("dateLabel",dateLabel), ("temperatureLabel",temperatureLabel), ("descriptionLabel",descriptionLabel)) as [String : Any]

        let metrics = Dictionary(dictionaryLiteral: ("padding", 10),("indexLabel",40),("labelHeight",24),("dateLabelHeight",160))

        let horizontal1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[dateLabel(==dateLabelHeight)]-padding-[temperatureLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)

        let horizontal2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[descriptionLabel]-20-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)

        let vertical1 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[dateLabel(==labelHeight)]-[descriptionLabel(==labelHeight)]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)

        let vertical2 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[temperatureLabel(==labelHeight)]-[descriptionLabel]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: views)

        var viewConstraints = [NSLayoutConstraint]()

        viewConstraints += horizontal1
        viewConstraints += horizontal2
        viewConstraints += vertical1
        viewConstraints += vertical2

        NSLayoutConstraint.activate(viewConstraints)
    }
    
}
