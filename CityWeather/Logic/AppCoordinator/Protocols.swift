//
//  Protocols.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import UIKit

// MARK: - Routable
protocol Routable: Presentable {

    func hideBar(isHidden: Bool)

    func present(_ module: Presentable?, animated: Bool)

    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, hideBottomBar: Bool, hideBar: Bool, completion: (() -> Void)?)

    func popModule(animated: Bool, hideBar: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)

    func setRootModule(_ module: Presentable?, hideBar: Bool)

    func popToRootModule(animated: Bool)
}

// MARK: - Presentable
protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}

// MARK: - Coordinatable
protocol Coordinatable: AnyObject {
    func start()
}
