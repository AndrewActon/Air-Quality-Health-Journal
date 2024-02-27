//
//  MapView.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/23/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var mapViewModel: MapViewModel
    @State private var position: MapCameraPosition = .userLocation(fallback: .camera(.init(centerCoordinate: CLLocationCoordinate2D(latitude: 40.7609409617829, longitude: -111.88497121223479), distance: 10000)))
    
    var body: some View {
        Map(position: $position) {
            ForEach(mapViewModel.stations, id: \.station.name) { station in
                Marker(station.station.name, monogram: Text(station.aqi), coordinate: CLLocationCoordinate2D(latitude: station.lat, longitude: station.lon))
                    .tint(mapViewModel.checkQualityOfAir(aqi: Int(station.aqi) ?? 901))
            }
        }
    }
}

#Preview {
    MapView()
}
