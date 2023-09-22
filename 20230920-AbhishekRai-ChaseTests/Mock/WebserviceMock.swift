//
//  WebserviceMock.swift
//  20230920-AbhishekRai-ChaseTests
//
//  Created by Abhishek Rai on 22/09/23.
//

import Foundation
@testable import WeatherApp

class WebserviceMock: WebserviceProtocol {
    
    func fetchWeather(url: URL?) async throws -> WeatherModel? {
        let jsonString = "{\"coord\":{\"lon\":73.8553,\"lat\":18.5196},\"weather\":[{\"id\":501,\"main\":\"Rain\",\"description\":\"moderate\",\"icon\":\"50d\"}],\"base\":\"stations\",\"main\":{\"temp\":324.14,\"feels_like\":233.31,\"temp_min\":237.14,\"temp_max\":237.14,\"pressure\":1010,\"humidity\":55},\"visibility\":2500,\"wind\":{\"speed\":4.12,\"deg\":254},\"clouds\":{\"all\":32},\"dt\":1681373098,\"sys\":{\"type\":1,\"id\":9052,\"country\":\"IN\",\"sunrise\":1695332232,\"sunset\":1681392297},\"timezone\":19800,\"id\":2345676,\"name\":\"Pune\",\"cod\":200}"
        let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: jsonString.data(using: .utf8) ?? Data())
        return weatherModel
    }
    
}
