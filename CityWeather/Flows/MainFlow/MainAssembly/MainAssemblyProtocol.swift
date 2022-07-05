//
//  MainAssemblyProtocol.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

protocol MainAssemblyProtocol {
    
    var appAssembly: AppAssemblyProtocol { get }
    
    func assembleCitiesListVC(with moduleOutput: CitiesListModuleOutput) -> CitiesListViewController
    func assembleCityWeatherVC(with moduleOutput: CityWeatherModuleOutput, city: City) -> CityWeatherViewController
}
