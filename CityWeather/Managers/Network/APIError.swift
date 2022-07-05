//
//  APIError.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import Foundation

enum APIError: Error {
    case decodingError
    case httpError(Int)
    case unknown
}
