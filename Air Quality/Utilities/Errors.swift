//
//  Errors.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/21/24.
//

import Foundation

enum AirQualityError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL"
        case .invalidResponse:
            return "The server responded with an invalid response"
        case .invalidData:
            return "Unable to decode data"
        }

    }
}

enum StationError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL"
        case .invalidResponse:
            return "The server responded with an invalid response"
        case .invalidData:
            return "Unable to decode data"
        }

    }

}
