//
//  HomeScreenView.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/17/24.
//

import SwiftUI
import CoreLocation

struct HomeScreenView: View {
    // MARK: - Properties
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @GestureState private var aqiZoom = 1.0
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("\(homeScreenViewModel.airQuality.city.name)")
                    .padding(.horizontal, 32)
                    .padding(.vertical, 32)

                Spacer()
            }
            .font(.system(size: 24, weight: .bold))
            
            HStack {
                ZStack {
                    Circle()
                        .foregroundStyle(homeScreenViewModel.aqiColor)
                        .frame(width: 120)
                    
                    VStack {
                        Text("AQI")
                        Text("\(homeScreenViewModel.airQuality.aqi)")
                    }
                    .font(.system(size: 18, weight: .regular))
                    .foregroundStyle(.white)
                }
                
                Text("\(homeScreenViewModel.healthImplications)")
            }
            .padding(.horizontal, 32)
            
            HStack {
                Text("Dominant Pollutant:")
                
                Text(homeScreenViewModel.airQuality.dominentpol)
                
                Spacer()
            }
            .font(.system(size: 18, weight: .regular))
            .padding(.horizontal, 32)
            .padding(.vertical, 18)
            
            Text("The table below defines the Air Quality Index scale as defined by the US-EPA 2016 standard:")
                .font(.system(size: 12, weight: .regular))
                .padding()
            
            Image("AQI Chart")
                .resizable()
                .scaledToFit()
                .scaleEffect(aqiZoom)
                .padding()
                .gesture(
                    MagnifyGesture()
                        .updating($aqiZoom, body: { value, gestureState, transaction in
                            gestureState = value.magnification
                        })
                )
            
            Spacer()
        }
    }
}

#Preview {
    HomeScreenView()
}
