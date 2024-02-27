//
//  HomeScreenViewModel.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/21/24.
//

import CoreLocation
import SwiftUI

@MainActor class HomeScreenViewModel: ObservableObject {
    @Published var airQuality: AirQuality = AirQuality(aqi: 0, idx: 0, city: City(geo: [0, 0], name: "Salt Lake City"), dominentpol: "O2")
    @Published var aqiColor: Color = Color.green
    @Published var healthImplications: String = "Air Quality Index scale as defined by the US-EPA 2016"
    
    func setupView(location: CLLocation) async {
        //Set airQuality
        guard let airQuality = await getAirQuality(location: location) else { return }
        self.airQuality = airQuality
        //Set Color
        let color = checkQualityOfAir(aqi: airQuality.aqi)
        self.aqiColor = color
        //Set Health implications
        let health = healthImplications(aqi: airQuality.aqi)
        self.healthImplications = health
    }
    
    func getAirQuality(location: CLLocation) async -> AirQuality? {
        do {
            let airQuality = try await NetworkManager.shared.getAirQualityForLocation(location: location)
            return airQuality
        } catch AirQualityError.invalidURL {
            print("The server failed to reach the necessary URL")
        } catch AirQualityError.invalidResponse {
            print("The server responded with an invalid response")
        } catch AirQualityError.invalidData {
            print("Unable to decode data")
        } catch {
            print("Unexpected error")
        }
        
        return nil
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
        case 300...:
            return Color(Color.black)
        default:
            return Color(Color.blue)
        }
    }
    
    func healthImplications(aqi: Int) -> String {
        switch aqi {
        case 0...50:
            return "Air quality is considered satisfactory, and air pollution poses little or no risk"
        case 51...100:
            return "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution."
        case 101...150:
            return "Members of sensitive groups may experience health effects. The general public is not likely to be affected."
        case 151...200:
            return "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects"
        case 201...300:
            return "Health warnings of emergency conditions. The entire population is more likely to be affected."
        case 300...:
            return "Health alert: everyone may experience more serious health effects"
        default:
            return "US-EPA 2016 standard"
        }
    }
}

