//
//  Date+.swift
//  YAWA-Demo
//
//  Created by Bink Wang on 9/5/18.
//  Copyright © 2018 Bink Wang. All rights reserved.
//

import Foundation

extension Date {
    static func printFormat(dt: Double?) -> String {
        var datePrintFormat = ""
        guard let dt = dt else { return datePrintFormat }
        
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        datePrintFormat = dateFormatterPrint.string(from: date)
        return datePrintFormat
    }
}
