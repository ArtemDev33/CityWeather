//
//  AppCoordinator.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

final class AppCoordinator: BaseCoordinator {

    private let router: Routable
    private let assembly: AppAssemblyProtocol
    
    init(router: Routable, assembly: AppAssemblyProtocol) {
        self.router = router
        self.assembly = assembly
    }

    override func start() {
        showMainCoordinator()
    }
}

// MARK: - Private
private extension AppCoordinator {

    func showMainCoordinator() {
        let mainCoordinator = assembly.assembleMainCoordinator(router: router)
        addDependency(mainCoordinator)
        mainCoordinator.start()
    }
}
