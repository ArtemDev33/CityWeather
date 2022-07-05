//
//  StoryboardLoadable.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import UIKit

protocol StoryboardLoadable: AnyObject {
    static func loadFromStoryboard() -> Self
}

extension NSObject {
    static func getClassName() -> String {
        NSStringFromClass(self).components(separatedBy: ".").last!
    }
}

extension StoryboardLoadable where Self: UIViewController {
    static func loadFromStoryboard() -> Self {
        let identifier = Self.getClassName()
        let storyboard = UIStoryboard(name: identifier, bundle: nil)

        guard let controller = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Error: Unable to load \(identifier) from storyboard")
        }

        return controller
    }
}
