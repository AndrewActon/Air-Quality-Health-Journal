//
//  NewEntrySheet.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/27/24.
//

import SwiftUI

struct NewEntrySheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    @State private var date: Date = .now
    @State private var o2Level: String = ""
    @State private var bloodPressure: String = ""
    @State private var heartRate: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                //Auto inputs
                Text(date, format: .dateTime.year().month(.abbreviated).day())
                Text(homeScreenViewModel.airQuality.city.name)
                Text("AQI: \(homeScreenViewModel.airQuality.aqi)")
                //User inputted
                TextField("O2 Level", text: $o2Level)
                    .keyboardType(.numberPad)
                TextField("Blood Pressure", text: $bloodPressure)
                    .keyboardType(.numberPad)
                TextField("Heart Rate", text: $heartRate)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("New Journal Entry")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        
                        let entry = JournalEntry(aqi: homeScreenViewModel.airQuality.aqi, location: homeScreenViewModel.airQuality.city.name, date: date, o2Levels: o2Level, bloodPressure: bloodPressure, heartRate: heartRate)
                        
                        context.insert(entry)
                        
                        do {
                            try context.save()
                            dismiss()
                        } catch {
                            print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NewEntrySheet()
}
