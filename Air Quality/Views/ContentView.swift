//
//  ContentView.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/16/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager.shared
    @ObservedObject var homeScreenViewModel = HomeScreenViewModel()
    @ObservedObject var mapViewMdoel = MapViewModel()

    var body: some View {
        Group {
            if locationManager.userLocation == nil {
                LocationRequestView()
            } else {
                TabView {
                    HomeScreenView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    MapView()
                        .tabItem {
                            Label("Map", systemImage: "map.fill")
                        }
                    JournalView()
                        .tabItem {
                            Label("Journal", systemImage: "book.pages.fill")
                        }
                }
                .task {
                    //Unwrap location
                    guard let location = locationManager.userLocation else { return }
                    //Home data
                    await homeScreenViewModel.setupView(location: location)
                    //Map data
                    await mapViewMdoel.setupView(location: location)
                }
            }
        }
        .environmentObject(homeScreenViewModel)
        .environmentObject(locationManager)
        .environmentObject(mapViewMdoel)
    }
    
}

#Preview {
    ContentView()
}
