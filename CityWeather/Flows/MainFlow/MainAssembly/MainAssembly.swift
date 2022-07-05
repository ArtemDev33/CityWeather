//
//  MainAssembly.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import UIKit
import CoreLocation

final class MainAssembly: MainAssemblyProtocol {
    
    let appAssembly: AppAssemblyProtocol
    
    init(with appAssembly: AppAssemblyProtocol) {
        self.appAssembly = appAssembly
    }
    
    func assembleCitiesListVC(with moduleOutput: CitiesListModuleOutput) -> CitiesListViewController {
        let view = CitiesListViewController.loadFromStoryboard()
        let storageManager = appAssembly.assembleStorageManager()
        let presenter = CitiesListPresenter(storageManager: storageManager)
        view.presenter = presenter
        presenter.view = view
        presenter.output = moduleOutput
        
        return view
    }
    
    func assembleCityWeatherVC(with moduleOutput: CityWeatherModuleOutput, city: City) -> CityWeatherViewController {
        let view = CityWeatherViewController.loadFromStoryboard()
        let networkManager = appAssembly.assembleNetworkManager()
        let presenter = CityWeatherPresenter(networkManager: networkManager)
        view.initialLocation = city.coordinates
        view.title = city.name
        view.presenter = presenter
        presenter.view = view
        presenter.output = moduleOutput
        
        return view
    }
}
