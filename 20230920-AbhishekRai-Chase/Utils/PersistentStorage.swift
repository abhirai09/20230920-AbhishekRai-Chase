//
//  PersistentStorage.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import Foundation

protocol RepositoryProtocol {
    func save(location: GeoLocation)
    func readLocation() -> GeoLocation?
}

class PersistantStorage: RepositoryProtocol {
     func save(location: GeoLocation) {
        if let encoded = try? JSONEncoder().encode(location) {
            UserDefaults.standard.set(encoded, forKey: "location")
        }
    }
    
     func readLocation() -> GeoLocation? {
        if let savedLocation = UserDefaults.standard.data(forKey: "location") {
            if let location = try? JSONDecoder().decode(GeoLocation.self, from: savedLocation) {
                return location
            }
        }
        return nil
    }
}
