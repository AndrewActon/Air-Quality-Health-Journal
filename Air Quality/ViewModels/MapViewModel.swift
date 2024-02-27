//
//  MapViewModel.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/23/24.
//

import SwiftUI
import CoreLocation
import _MapKit_SwiftUI

@MainActor class MapViewModel: ObservableObject {
    @Published var stations: [Station] = []
    
    func setupView(location: CLLocation) async {
        let foundStations = await getStations(location: location)
        self.stations = foundStations
    }
    
    func getStations(location: CLLocation) async -> [Station] {
        //Parse coordinates
        let latitude = Double(location.coordinate.latitude)
        let longitude = Double(location.coordinate.longitude)
        //Calculate new points
        let northernPoint = calculateNortherPoint(latitude: latitude, longitude: longitude)
        let southernPoint = calculateSouthernPoint(latitude: latitude, longitude: longitude)
        //Network call
        do {
            let stations = try await NetworkManager.shared.getStations(northernPoint: northernPoint, southernPoint: southernPoint)
            return stations
        } catch StationError.invalidURL {
            print("The server failed to reach the necessary URL")
        } catch StationError.invalidResponse {
            print("The server responded with an invalid response")
        } catch StationError.invalidData {
            print("Unable to decode data")
        } catch {
            print("Unexpected error")
        }
        
        return []
    }
    
    func calculateNortherPoint(latitude: Double, longitude: Double) -> CLLocation {
        //Calculate new latitude
        let newLat = latitude + 0.22609293323927868
        //Calculate new longitude
        let newLonDeg = 25 / (111.320 * cos (latitude) )
        let newLon = longitude + newLonDeg
        
        return CLLocation(latitude: newLat, longitude: newLon)
    }
    
    func calculateSouthernPoint(latitude: Double, longitude: Double) -> CLLocation {
        //Calculate new latitude
        let newLat = latitude - 0.22609293323927868
        //Calculate new longitude
        let newLonDeg = 25 / (111.320 * cos (latitude) )
        let newLon = longitude - newLonDeg
        
        return CLLocation(latitude: newLat, longitude: newLon)
    }
    
    func checkQualityOfAir(aqi: Int) -> Color {
        switch aqi {
        case 0...50:
            return Color(Color.green)
        case 51...100:
            return Color(Color.yellow)
        case 101...150:
            return Color(Color.orange)
        case 151...200:
            return Color(Color.red)
        case 201...300:
            return Color(Color.purple)
        case 300...900:
            return Color(Color.black)
        default:
            return Color(Color.blue)
        }
    }
}
