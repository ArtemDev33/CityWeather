//
//  CityWeatherPresenter.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import Foundation
import Combine

final class CityWeatherPresenter: CityWeatherViewOutput {
    
    weak var view: CityWeatherViewInput?
    var output: CityWeatherModuleOutput?
    
    private let networkManager: NetworkManagerProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func viewDidFinishLoading(with coordinates: Coordinates?) {
        guard let coords = coordinates else {
            return
        }
        
        networkManager.fetchWeather(coordinates: coords)
            .sink(receiveCompletion: { result in
                                
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                case .finished:
                    break
                }
            }) { [weak self] weatherResponse in
                let vmodel = WeatherInfoViewModel(weatherResponse: weatherResponse)
                self?.view?.configureUI(with: vmodel)
            }.store(in: &cancellables)
    }
}
