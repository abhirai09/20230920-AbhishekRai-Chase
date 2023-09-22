//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import Foundation

struct WeatherModel: Decodable {
    let weather: [Weather]?
    let main: Main?
    let dt: Int?
    let timezone, id: Int?
    let name: String?
    let coord: Coordintes?
}

struct Coordintes: Decodable {
    let lat: Double?
    let lon: Double?
}

struct Main: Decodable {
    let temp, temp_min, temp_max, humidity: Double?

}

struct Weather: Decodable {
    let id: Int?
    let main, description, icon: String?
}

