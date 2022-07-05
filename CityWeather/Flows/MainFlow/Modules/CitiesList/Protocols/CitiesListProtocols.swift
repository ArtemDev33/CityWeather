//
//  CitiesListProtocols.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 05.07.2022.
//

import Foundation

// MARK: - View
protocol CitiesListViewInput: AnyObject {
    func setCities(cities: [City])
}

// MARK: - Presenter
protocol CitiesListViewOutput {
    func viewDidFinishLoading()
    func viewDidSelectCity(city: City)
}

// MARK: - Coordinator
protocol CitiesListModuleOutput {
    func cityListModuleDidSelectCity(city: City)
}
