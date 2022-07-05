//
//  CityWeatherProtocols.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 05.07.2022.
//

import Foundation

// MARK: - View
protocol CityWeatherViewInput: AnyObject {
    func configureUI(with vmodel: WeatherInfoViewModel)
}

// MARK: - Presenter
protocol CityWeatherViewOutput {
    func viewDidFinishLoading(with coordinates: Coordinates?)
}

// MARK: - Coordinator
protocol CityWeatherModuleOutput { }
