//
//  ApiServiceProtocol.swift
//  YAWA-Demo
//
//  Created by bink.wang on 14/07/20.
//  Copyright © 2020 Bink Wang. All rights reserved.
//

import Foundation

protocol ApiServiceProtocol {
    func callApi<ResponseModel: Decodable>
        (request: URLRequest,
         modelType: ResponseModel.Type,
         completion: @escaping (Result<ResponseModel, Error>) -> Void)
}

enum ApiError: Error {
    case unknown
    case nilResponse
    case invalidResponse
    case decodeFailed
}
