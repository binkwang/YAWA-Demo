//
//  TestHelper.swift
//  YAWA-DemoTests
//
//  Created by bink.wang on 7/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import XCTest

extension Bundle {
    func getJSONData(from jsonFile: String) throws -> Data {
        return try getData(from: jsonFile, with: "json")
    }
    
    func getXMLData(from xmlFile: String) throws -> Data {
        return try getData(from: xmlFile, with: "xml")
    }
    
    func getData(from filePath: String, with fileExtension: String) throws -> Data {
        guard let url = self.url(forResource: filePath, withExtension: fileExtension) else {
            throw NSError(domain: NSURLErrorDomain, code: NSNotFound, userInfo: nil)
        }
    
        return try Data(contentsOf: url, options: .mappedIfSafe)
    }
    
    func getJSONDictionary(from jsonFile: String) throws -> [AnyHashable: Any] {
        let data = try getJSONData(from: jsonFile)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return json as? [AnyHashable: Any] ?? [:]
    }
    
    func getJSONArray(from jsonFile: String) throws -> [Any] {
        let data = try getJSONData(from: jsonFile)
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return json as? [Any] ?? []
    }
}
