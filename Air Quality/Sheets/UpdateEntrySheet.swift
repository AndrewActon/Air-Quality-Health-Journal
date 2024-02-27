//
//  UpdateEntrySheet.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/27/24.
//

import SwiftUI

struct UpdateEntrySheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var entry: JournalEntry
    
    var body: some View {
        NavigationStack {
            Form {
                //Auto inputs
                Text(entry.date, format: .dateTime.year().month(.abbreviated).day())
                Text(entry.location)
                Text("AQI: \(entry.aqi)")
                //User inputted
                TextField("O2 Level", text: $entry.o2Levels)
                    .keyboardType(.numberPad)
                TextField("Blood Pressure", text: $entry.bloodPressure)
                    .keyboardType(.numberPad)
                TextField("Heart Rate", text: $entry.heartRate)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Update Journal Entry")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

