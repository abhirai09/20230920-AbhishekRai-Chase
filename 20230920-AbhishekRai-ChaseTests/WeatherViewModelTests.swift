//
//  WeatherViewModelTests.swift
//  20230920-AbhishekRai-ChaseTests
//
//  Created by Abhishek Rai on 22/09/23.
//

import XCTest
@testable import WeatherApp


final class WeatherViewModelTests: XCTestCase {
    
    var weatherViewModel: WeatherViewModel!
    
    override func setUp() {
        weatherViewModel = WeatherViewModel(webservice: WebserviceMock())
    }
    
    override func tearDown() {
        weatherViewModel = nil
    }
    
    func test_citySearch_withMockData() async {
       await weatherViewModel.fetchWeatherDetails(city: "Pune")
        XCTAssertEqual(weatherViewModel.weatherInfo?.name, "Pune")
    }
    
    func test_geoLocation_withMockData() async {
       await weatherViewModel.fetchWeatherDetails(geoLocation: GeoLocation(name: nil, lat: 18.5196, lon: 73.8553))
       XCTAssertNotNil(weatherViewModel.weatherInfo)
        XCTAssertEqual(weatherViewModel.weatherInfo?.name, "Pune")
    }
    
    /**
     Likewise above other API related test cases can be written for pass/fail scenarios.
     */


}
