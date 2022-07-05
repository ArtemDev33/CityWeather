//
//  AppDelegate.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private(set) var appCoordinator: AppCoordinator!
    private(set) var appAssembly: AppAssemblyProtocol!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let applicationAssembly = AppAssembly()
        let navigationController = UINavigationController()
        let router = Router(rootController: navigationController)
        
        appAssembly = applicationAssembly
        appCoordinator = applicationAssembly.assembleAppCoordinator(router: router)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        appCoordinator.start()
        
        return true
    }
}
