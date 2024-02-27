//
//  Station.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/26/24.
//

import Foundation

struct TopLevelStationData: Decodable {
    var data: [Station]
}

struct Station: Decodable {
    var lat: Double
    var lon: Double
    var aqi: String
    var station: StationDetails
}

struct StationDetails: Decodable {
    var name: String
    var time: String
}
