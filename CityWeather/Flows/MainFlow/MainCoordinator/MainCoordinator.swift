//
//  MainCoordinator.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

final class MainCoordinator: BaseCoordinator {

    private let router: Routable
    private let assembly: MainAssemblyProtocol
    
    init(router: Routable, assembly: MainAssemblyProtocol) {
        self.router = router
        self.assembly = assembly
    }

    override func start() {
        showCitiesListVC()
    }
}

// MARK: - Private
private extension MainCoordinator {
    
    func showCitiesListVC() {
        let citiesListVC = assembly.assembleCitiesListVC(with: self)
        router.setRootModule(citiesListVC, hideBar: false)
    }
    
    func showCityWeatherVC(city: City) {
        let cityWeatherVC = assembly.assembleCityWeatherVC(with: self, city: city)
        router.push(cityWeatherVC, animated: true)
    }
}

// MARK: - CitiesListModuleOutput
extension MainCoordinator: CitiesListModuleOutput {
    
    func cityListModuleDidSelectCity(city: City) {
        showCityWeatherVC(city: city)
    }
}

// MARK: - CityWeatherModuleOutput
extension MainCoordinator: CityWeatherModuleOutput {
    
}
