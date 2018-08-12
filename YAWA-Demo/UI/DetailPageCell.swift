//
//  DetailPageCell.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import UIKit

internal let kDetailPageCellReuseIdentifier = "DetailPageCell"


class DetailPageCell: UITableViewCell {
    var labelText: String? {
        didSet {
            label.text = labelText
        }
    }
    var weatherCode: String? {
        didSet {
            RemoteDataRequestCenter.getWeatherImage(code: weatherCode) { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    if let data = data {
                        self.weatherIconView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var weatherIconView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
