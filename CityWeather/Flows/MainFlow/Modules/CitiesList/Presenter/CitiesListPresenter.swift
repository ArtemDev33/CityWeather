//
//  CitiesListPresenter.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

final class CitiesListPresenter: CitiesListViewOutput {
    
    weak var view: CitiesListViewInput?
    var output: CitiesListModuleOutput?
    
    let storageManager: StorageManagerProtocol
    
    init(storageManager: StorageManagerProtocol) {
        self.storageManager = storageManager
    }
    
    func viewDidFinishLoading() {
        let cities = storageManager.cities
        view?.setCities(cities: cities)
    }
    
    func viewDidSelectCity(city: City) {
        output?.cityListModuleDidSelectCity(city: city)
    }
}
