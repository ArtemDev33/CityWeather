//
//  AppAssemblyProtocol.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

protocol AppAssemblyProtocol {
    
    // Coordinators
    func assembleAppCoordinator(router: Routable) -> AppCoordinator
    func assembleMainCoordinator(router: Routable) -> MainCoordinator
    
    // Managers
    func assembleStorageManager() -> StorageManagerProtocol
    func assembleNetworkManager() -> NetworkManagerProtocol
}
