//
//  PersistentStorageTests.swift
//  20230920-AbhishekRai-ChaseTests
//
//  Created by Abhishek Rai on 22/09/23.
//

import XCTest
@testable import WeatherApp

final class PersistentStorageTests: XCTestCase {
    
    var storage: PersistantStorage!
    
    override func setUp() {
        storage = PersistantStorage()
    }
    
    override func tearDown() {
        storage = nil
    }
    
    func test_location_Save() {
        let geoLocation = GeoLocation(name: "Pune", lat: 18.5196, lon: 73.8553)
        storage.save(location: geoLocation)
        let location = storage.readLocation()
        XCTAssertNotNil(location)
        XCTAssertEqual(location?.name, "Pune")
    }
}
