//
//  WeatherInfoViewModel.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import Foundation

struct WeatherInfoViewModel {
    let description: String
    let currentTemp: String
    let minMaxTemp: String
    let humidity: String
    let windSpeed: String
    
    init(weatherResponse: WeatherResponse) {
        description = weatherResponse.description?.capitalized ?? ""
        currentTemp = "t: \(weatherResponse.tempCurrent) °C"
        minMaxTemp = "min: \(weatherResponse.tempMin) °C, max: \(weatherResponse.tempMax) °C"
        humidity = "\(weatherResponse.humidity) %"
        windSpeed = "\(weatherResponse.windSpeed) km/h"
    }
}
