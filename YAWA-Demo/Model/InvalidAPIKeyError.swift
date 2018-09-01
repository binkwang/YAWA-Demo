//
//  InvalidAPIKeyError.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 8/12/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

class InvalidAPIKeyError {
    var cod: Int?
    var message: String?
    
    init(with dictionary: [String: Any]?) {
        guard let dictionary = dictionary else { return }
        cod = dictionary["cod"] as? Int
        message = dictionary["message"] as? String
    }
}

/** Json example
{
    cod: 401,
    message: "Invalid API key. Please see http://openweathermap.org/faq#error401 for more info."
}
**/
