//
//  WeatherEndpoint.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import Foundation

enum WeatherEndpoint {
    case openCall(coordinates: Coordinates)
}

extension WeatherEndpoint {
    
    var urlRequest: URLRequest {
        switch self {
        case .openCall(let coordinates):
            
            var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
            urlComponents?.queryItems = [
                URLQueryItem(name: "lat", value: String(coordinates.lat)),
                URLQueryItem(name: "lon", value: String(coordinates.lon)),
                URLQueryItem(name: "units", value: "metric"),
                URLQueryItem(name: "appid", value: "43f9c080f75b826421df4f04e05c843c")
            ]
            
            guard let url = urlComponents?.url else {
                preconditionFailure("Invalid URL format")
            }
            
            let request = URLRequest(url: url)
            return request
        }
    }
}
