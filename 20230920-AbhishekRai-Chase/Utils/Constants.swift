//
//  Constants.swift
//  20230920-AbhishekRai-Chase
//
//  Created by Abhishek Rai on 20/09/23.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case serialization
}

struct Constants {
    
    static private let baseURL = "https://api.openweathermap.org/data/2.5"
    static private let apiKey = "0bd25a9ea0c32ffdecc56394431c5dcc"
    static private let resourceURL = "https://openweathermap.org"
    
    struct Urls {
        static func details(byCity: String) -> URL? {
            return URL(string: baseURL + "/weather?q=\(byCity)&appid=\(apiKey)&units=metric")
        }
        
        static func details(byLocation: GeoLocation) -> URL? {
            guard let lat = byLocation.lat, let lon = byLocation.lon else { return nil }
            return URL(string: baseURL + "/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric")
        }
        
        static func urlForImage(named: String) -> URL? {
            return URL(string: resourceURL + "/img/wn/\(named)@2x.png")
        }
        
    }
    
}
