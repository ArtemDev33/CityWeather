//
//  StorageManager.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation

// MARK: - Protocol
protocol StorageManagerProtocol {
    var cities: [City] { get }
}

// MARK: - Class
final class StorageManager: StorageManagerProtocol {
    
    private(set) var cities: [City] = []
    
    init() {
        self.cities = getCities()
    }
}

// MARK: - Private
private extension StorageManager {
    
    func getCities() -> [City] {
        guard let path = Bundle.main.path(forResource: "city_list", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let cities = try? JSONDecoder().decode([City].self, from: data)
        else {
            return []
        }
        
        return cities
    }
}
