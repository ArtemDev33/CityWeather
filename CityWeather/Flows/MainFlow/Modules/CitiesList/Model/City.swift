//
//  City.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 03.07.2022.
//

import Foundation


struct City: Decodable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coordinates: Coordinates
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case state
        case country
        case coordinates = "coord"
    }
}

struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
}
