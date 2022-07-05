//
//  AppAssembly.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

// MARK: - CLass
final class AppAssembly {
    
    private lazy var storageManager: StorageManagerProtocol = {
        return StorageManager()
    }()
    
    private lazy var networkManager: NetworkManagerProtocol = {
        return NetworkManager()
    }()
}

// MARK: - AppAssemblyProtocol
extension AppAssembly: AppAssemblyProtocol {
    
    // Managers
    func assembleStorageManager() -> StorageManagerProtocol { storageManager }
    func assembleNetworkManager() -> NetworkManagerProtocol { networkManager }
    
    // Coordinators
    func assembleAppCoordinator(router: Routable) -> AppCoordinator {
        AppCoordinator(router: router, assembly: self)
    }
    
    func assembleMainCoordinator(router: Routable) -> MainCoordinator {
        let mainAssembly = MainAssembly(with: self)
        return MainCoordinator(router: router, assembly: mainAssembly)
    }
}
