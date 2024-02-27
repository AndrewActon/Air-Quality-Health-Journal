//
//  AirQuality.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/21/24.
//

import Foundation

struct TopLevelAirQuality: Decodable {
    var data: AirQuality
    
}

struct AirQuality: Decodable {
    var aqi: Int
    var idx: Int
    var city: City
    var dominentpol: String
//    var forecast: Forecast
}

struct City: Decodable {
    var geo: [Double]
    var name: String
}

struct Forecast: Decodable {
    var daily: Daily
}

struct Daily : Decodable {
    var o3: [O3]
    var pm10: [PM10]
    var pm25: [PM25]
    var uvi: [UVI]
}

struct O3: Decodable {
    var avg: Int
    var day: String
    var max: Int
    var min: Int
}

struct PM10: Decodable {
    var avg: Int
    var day: String
    var max: Int
    var min: Int
}

struct PM25: Decodable {
    var avg: Int
    var day: String
    var max: Int
    var min: Int
}

struct UVI: Decodable {
    var avg: Int
    var day: String
    var max: Int
    var min: Int
}
