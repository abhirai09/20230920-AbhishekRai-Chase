//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import CoreLocation

class LocationManager: NSObject {
    private var locationManager = CLLocationManager()
    var locationUpdated: ((CLLocation) -> Void)?
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        requestLocationAccess()
    }
    
    private func requestLocationAccess() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            requestLocationAccess()
        case .restricted, .denied:
            debugPrint("Access restricted or Denied")
        default:
            break
        }
    }

    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationUpdated?(location)
        }
    }
}
