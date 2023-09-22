//
//  Webservice.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import Foundation

protocol WebserviceProtocol {
    func fetchWeather(url: URL?) async throws -> WeatherModel?
}

class Webservice: WebserviceProtocol {
    
    func fetchWeather(url: URL?) async throws -> WeatherModel? {
        guard let url = url else { return nil }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        if (200..<300).contains(httpResponse.statusCode) {
            do {
                let weatherInfo = try JSONDecoder().decode(WeatherModel.self, from: data)
                return weatherInfo
            } catch  {
                throw NetworkError.serialization
            }
            
        } else {
            switch httpResponse.statusCode {
            case 404:
                throw NetworkError.notFound
            default:
                throw NetworkError.unauthorized
               // Handle other scenarios for failure.
            }
        }
    }
    
}
