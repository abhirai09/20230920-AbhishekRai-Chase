//
//  LocationDetails.swift
//  WeatherApp
//
//  Created by Abhishek Rai on 21/09/23.
//

import SwiftUI
import MapKit

struct TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.gray)
            .padding(5)
    }
}

struct LocationDetails: View {
    var location: GeoLocation
    var navTitle: String {
        guard let title = location.name else { return "Details" }
        return "\(title)'s Weather"
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 42/255, green: 49/255, blue: 78/255).ignoresSafeArea()
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Cordinates").titleModifier()
                        Text("Latitude: " + String(location.lat ?? 0.0 )).titleModifier()
                        Text("Longitude: " +  String(location.lon ?? 0.0)).titleModifier()
                    }
                    let locationCoordinates = CLLocationCoordinate2D(latitude: location.lat ?? 0.0, longitude: location.lon ?? 0.0)
                    MapView(coordinates: locationCoordinates)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
    }
}

struct MapView: View {
    let coordinates: CLLocationCoordinate2D

    var body: some View {
        Map(coordinateRegion: .constant(
            MKCoordinateRegion(
                center: coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            )
        ))
    }
}

struct LocationDetails_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetails(location: GeoLocation(name: nil, lat: 18.5196, lon: 73.8553))
    }
}
