//
//  ApiService.swift
//  YAWA-Demo
//
//  Created by bink.wang on 14/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation


class ApiService: ApiServiceProtocol {
    
    func callApi<ResponseModel: Decodable>
        (request: URLRequest,
         modelType: ResponseModel.Type,
         completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                response.isValidResponse else {
                completion(.failure(ApiError.invalidResponse))
                return
            }
            
            do {
                let object = try ApiUtils.object(from: data, type: modelType.self)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }).resume()
    }
}

fileprivate extension HTTPURLResponse {
    static let successResponseCodeRange = 200..<299
    
    var isValidResponse: Bool {
        return HTTPURLResponse.successResponseCodeRange ~= statusCode
    }
}
