//
//  WeatherResponse.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import Foundation


struct WeatherResponse: Decodable {
    let description: String?
    let tempCurrent: Float
    let tempMin: Float
    let tempMax: Float
    let humidity: Float
    let windSpeed: Float
    
    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case wind
    }
    
    enum MainCodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
    
    enum WeatherCodingKeys: String, CodingKey {
        case description
    }
    
    enum WindCodingKeys: String, CodingKey {
        case speed
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let mainContainer = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        self.tempCurrent = try mainContainer.decode(Float.self, forKey: .temp)
        self.humidity = try mainContainer.decode(Float.self, forKey: .humidity)
        self.tempMin = try mainContainer.decode(Float.self, forKey: .tempMin)
        self.tempMax = try mainContainer.decode(Float.self, forKey: .tempMax)
                
        var description: String?
        var weatherUnkeyedContainer = try container.nestedUnkeyedContainer(forKey: .weather)
        while !weatherUnkeyedContainer.isAtEnd {
            let weatheContainer = try weatherUnkeyedContainer.nestedContainer(keyedBy: WeatherCodingKeys.self)
            description = try weatheContainer.decode(String.self, forKey: .description)
            if description != nil {
                break
            }
        }
        
        self.description = description
        
        let windContainer = try container.nestedContainer(keyedBy: WindCodingKeys.self, forKey: .wind)
        self.windSpeed = try windContainer.decode(Float.self, forKey: .speed)
    }
}
