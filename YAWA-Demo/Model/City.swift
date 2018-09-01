//
//  City.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class City {
    var id: Int?
    var name: String?
    var country: String?
    var population: Int?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        country = dictionary["country"] as? String
        population = dictionary["population"] as? Int
    }
}

/** Example JSON
 {
 id: 2643743,
 name: "London",
 coord: {
 lon: -0.1277,
 lat: 51.5073
 },
 country: "GB",
 population: 1000000
 }
 **/

