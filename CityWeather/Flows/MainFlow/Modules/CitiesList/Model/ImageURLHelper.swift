//
//  ImageURLHelper.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import UIKit

enum ImageURLHelper {
    case even, odd
    
    var imageURL: String {
        switch self {
        case .even:
            return "https://infotech.gov.ua/storage/img/Temp3.png"
        case .odd:
            return "https://infotech.gov.ua/storage/img/Temp1.png"
        }
    }
}
