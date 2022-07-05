//
//  NetworkManager.swift
//  CityWeather
//
//  Created by Артем Гавриленко on 04.07.2022.
//

import Foundation
import Combine

// MARK: - Protocol
protocol NetworkManagerProtocol {
    func fetchWeather(coordinates: Coordinates) -> AnyPublisher<WeatherResponse, APIError>
}

// MARK: - Class
final class NetworkManager: NetworkManagerProtocol {
    
    func fetchWeather(coordinates: Coordinates) -> AnyPublisher<WeatherResponse, APIError> {
        let endPoint = WeatherEndpoint.openCall(coordinates: coordinates)
        return execute(request: endPoint.urlRequest)
    }
}

// MARK: - Private
private extension NetworkManager {
    
    func execute<T>(request: URLRequest, queue: DispatchQueue = .main) -> AnyPublisher<T, APIError> where T: Decodable {
                
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let response = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                guard (200...299).contains(response.statusCode) else {
                    throw APIError.httpError(response.statusCode)
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch {
                    throw APIError.decodingError
                }
            }
            .mapError { error in
                error as? APIError ?? .unknown
            }
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
