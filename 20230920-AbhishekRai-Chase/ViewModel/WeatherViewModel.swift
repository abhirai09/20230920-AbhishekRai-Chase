//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import Foundation
import CoreLocation

protocol WeatherViewModelProtocol {
    func fetchWeatherDetails(city: String) async
    func fetchWeatherDetails(geoLocation: GeoLocation) async
    func numberOfRows() -> Int
    func getRowModel(atIndex: Int) -> WeatherAppRowProtocol?
    func getCityName() -> String?
    func clearTextfield()
    func lastCitySearched() -> GeoLocation?
}

class WeatherViewModel: WeatherViewModelProtocol {
    private var rowViewModel: RowViewModel?
    private let locationManager = LocationManager()
    private let persistentStorage: RepositoryProtocol = PersistantStorage()
    let webserive: WebserviceProtocol
    var weatherInfo: WeatherModel?
    var reloadUI: () -> Void = { }
    var locationUpdated: ((CLLocation) -> Void)? {
        get { return locationManager.locationUpdated }
        set { locationManager.locationUpdated = newValue }
    }
    
    init(webservice: WebserviceProtocol) {
        self.webserive = webservice
    }
    
    func fetchWeatherDetails(city: String) async {
        if let city = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            await loadCityWeatherDetails(url: Constants.Urls.details(byCity: city))
        }
    }
    
    func fetchWeatherDetails(geoLocation: GeoLocation) async {
        persistentStorage.save(location: geoLocation)
        await loadCityWeatherDetails(url: Constants.Urls.details(byLocation: geoLocation))
    }
    
    func loadCityWeatherDetails(url: URL?) async {
        do {
            let weatherDetails = try await webserive.fetchWeather(url: url)
            self.weatherInfo = weatherDetails
            saveGelocation()
            self.rowViewModel = RowViewModel(weather: weatherInfo)
        } catch NetworkError.serialization {
            debugPrint("Show Meaningful error to user")
        } catch NetworkError.notFound {
            debugPrint("Resource not found")
        } catch {
            debugPrint("Handle other errors")
        }
        /**
         All types of error can be captured in respective catch block. Based on business required functionality can be implemented to inform user about the failure or giving him other options like retry etc.
         */
    }
    
    private func saveGelocation() {
        persistentStorage.save(location: GeoLocation(name: weatherInfo?.name, lat: weatherInfo?.coord?.lat, lon: weatherInfo?.coord?.lon))
    }
    
    func numberOfRows() -> Int {
        return rowViewModel?.dataSource.count ?? 0
    }
    
    func getRowModel(atIndex: Int) -> WeatherAppRowProtocol? {
        if rowViewModel?.dataSource.indices.contains(atIndex) == true {
            return rowViewModel?.dataSource[atIndex]
        }
        return nil
    }
    
    func getCityName() -> String? {
        return self.weatherInfo?.name
    }
    
    func clearTextfield() {
        weatherInfo = nil
        rowViewModel?.dataSource = []
        reloadUI()
    }
    
    func lastCitySearched() -> GeoLocation? {
        return persistentStorage.readLocation()
    }
}
