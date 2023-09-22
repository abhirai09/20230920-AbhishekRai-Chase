//
//  RowViewModel.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import Foundation

enum RowType {
    case basicDetails
    case airPressureDetails
}

protocol WeatherAppRowProtocol {
    var type: RowType { get set }
}

struct BasicRowModel: WeatherAppRowProtocol {
    var type: RowType
    let model: WeatherModel
    var cityName: String { model.name ?? "" }
    var temperature: String {
        guard let temp = model.main?.temp else { return "" }
        return String(format: "%.0f",temp).withDegreeSymbol
    }
    var url: URL? {
        guard let weather = model.weather?.first as? Weather, let urlString = weather.icon else { return nil }
        return Constants.Urls.urlForImage(named: urlString)
    }
    init(type: RowType, weather: WeatherModel) {
        self.type = type
        self.model = weather
    }
}

struct AirPressureRowModel: WeatherAppRowProtocol {
    var type: RowType
    let model: WeatherModel
    var humidity: String {
        guard let airHumidity = model.main?.humidity else { return "" }
        return String(format: "%.0f",airHumidity)
    }
    var highTemp: String {
        guard let temp_max = model.main?.temp_max else { return "" }
        return String(format: "%.0f",temp_max).withDegreeSymbol
    }
    var lowTemp: String {
        guard let temp_min = model.main?.temp_min else { return "" }
        return String(format: "%.0f",temp_min).withDegreeSymbol
    }
    init(type: RowType, weather: WeatherModel) {
        self.type = type
        self.model = weather
    }
}

class RowViewModel {
    private var weatherModel: WeatherModel?
    var dataSource: [WeatherAppRowProtocol] = []
    init(weather: WeatherModel?) {
        if let weather = weather {
            self.weatherModel = weather
            let basicDetail = BasicRowModel(type: .basicDetails, weather: weather)
            self.dataSource.append(basicDetail)
            let airPressure = AirPressureRowModel(type: .airPressureDetails, weather: weather)
            self.dataSource.append(airPressure)
        }
    }
}
