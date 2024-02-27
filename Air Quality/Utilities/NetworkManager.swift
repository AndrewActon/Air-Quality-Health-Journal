//
//  NetworkManager.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/21/24.
//

import CoreLocation

class NetworkManager {
    static let shared = NetworkManager()
    
    // MARK: - Constants
    let baseURL: String = "https://api.waqi.info"
    let token: String = "10363bde78e1e62e4878afbcd552ad251467b36d"
    let geoEndpoint: String = "/feed/geo:"
    let mapEndpoint: String = "/v2/map/bounds"
    
    // MARK: - Methods
    func getAirQualityForLocation(location: CLLocation) async throws -> AirQuality {
        //Parse location
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        //Convert location to string
        let latitudeString = String(latitude)
        let longitudeString = String(longitude)
        let latLongCombo = "\(latitudeString);\(longitudeString)"
        //Concatenate Strings
        let geoWithCoordsEndpoint = geoEndpoint + latLongCombo
        let finalEndpoint = baseURL + geoWithCoordsEndpoint
        //Query Component
        let query = URLQueryItem(name: "token", value: token)
        //Build URL
        guard let url = URL(string: finalEndpoint) else { throw AirQualityError.invalidURL}
        let finalURL = url.appending(queryItems: [query])
        print(finalURL)
        //Create Request
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        //Data Task
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw AirQualityError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let topLevelData = try decoder.decode(TopLevelAirQuality.self, from: data)
            let airQualityData = topLevelData.data
            return airQualityData
        } catch {
            throw AirQualityError.invalidData
        }
    }
    
    func getStations(northernPoint: CLLocation, southernPoint: CLLocation) async throws -> [Station] {
        //Parse lat/long
        let latitude1 = Double(northernPoint.coordinate.latitude)
        let latitude2 = Double(southernPoint.coordinate.latitude)
        let longitude1 = Double(northernPoint.coordinate.longitude)
        let longitude2 = Double(southernPoint.coordinate.longitude)
        //Queries
        let latLon = "\(latitude1),\(longitude1),\(latitude2),\(longitude2)"
        let latLngQuery = URLQueryItem(name: "latlng", value: latLon)
        let tokenQuery = URLQueryItem(name: "token", value: token)
        //Build URL
        let urlString = baseURL + mapEndpoint
        guard let url = URL(string: urlString) else { throw StationError.invalidURL }
        let finalURL = url.appending(queryItems: [latLngQuery, tokenQuery])
        //Create Request
        var request = URLRequest(url: finalURL)
        request.httpMethod = "GET"
        //Data Task
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw StationError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let topLevelData = try decoder.decode(TopLevelStationData.self, from: data)
            let stationData = topLevelData.data
            return stationData
        } catch {
            throw StationError.invalidData
        }
    }
    
}
