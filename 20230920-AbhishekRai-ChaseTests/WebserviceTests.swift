//
//  WebserviceTests.swift
//  20230920-AbhishekRai-ChaseTests
//
//  Created by Abhishek Rai on 22/09/23.
//

import XCTest
@testable import WeatherApp

final class WebserviceTests: XCTestCase {
    var webservice: Webservice!
    
    override func setUp() {
        webservice = Webservice()
    }
    
    override func tearDown() {
        webservice = nil
    }
    
    // MARK: - Acutal API Testing
    func test_wrongURL() async throws {
        let url = URL(string: "")
        let result = try await webservice.fetchWeather(url: url)
        XCTAssertNil(result)
    }
    
    func test_citySearch() async throws {
        let result = try await webservice.fetchWeather(url: Constants.Urls.details(byCity: "Pune"))
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "Pune")
    }
    
    func test_geoLocation() async throws {
        let result = try await webservice.fetchWeather(url: Constants.Urls.details(byLocation: GeoLocation(name: nil, lat: 18.5196, lon: 73.8553)))
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "Pune")
    }
}
