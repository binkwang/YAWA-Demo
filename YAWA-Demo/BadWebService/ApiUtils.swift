//
//  ApiUtils.swift
//  YAWA-Demo
//
//  Created by bink.wang on 14/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

class ApiUtils {
    
    static func object<T: Decodable>(from jsonData: Data?, type: T.Type) throws -> T {
        let jsonDecoder = JSONDecoder()
        
        guard let jsonData = jsonData else {
            throw ApiError.nilResponse
        }
        
        guard let object = try? jsonDecoder.decode(T.self, from: jsonData) else {
            throw ApiError.decodeFailed
        }
        
        return object
    }
}
