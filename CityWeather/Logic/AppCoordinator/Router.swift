//
//  Router.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import UIKit

final class Router: Routable {

    private let rootController: UINavigationController
    private var completions: [UIViewController : () -> Void]

    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    func hideBar(isHidden: Bool) {
        rootController.isNavigationBarHidden = isHidden
    }

    func toPresent() -> UIViewController? {
        rootController
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }

        rootController.present(controller, animated: animated, completion: nil)
    }

    func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController.dismiss(animated: animated, completion: completion)
    }

    func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, hideBottomBar: false, hideBar: false, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, hideBar: Bool, completion: (() -> Void)?) {
        guard let controller = module?.toPresent() else {
            return
        }

        if let completion = completion {
            completions[controller] = completion
        }
        
        rootController.navigationBar.prefersLargeTitles = !hideBar
        rootController.pushViewController(controller, animated: animated)
    }

    func popModule(animated: Bool, hideBar: Bool) {
        if let controller = rootController.popViewController(animated: animated) {
            rootController.isNavigationBarHidden = hideBar
            runCompletion(for: controller)
        }
    }

    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController.setViewControllers([controller], animated: false)
        rootController.navigationBar.prefersLargeTitles = true
        rootController.isNavigationBarHidden = hideBar
    }

    func popToRootModule(animated: Bool) {
        if let controllers = rootController.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}
