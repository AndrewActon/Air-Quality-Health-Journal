//
//  JournalEntry.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/26/24.
//

import Foundation
import SwiftData

@Model
class JournalEntry {
    var aqi: Int
    var location: String
    var date: Date
    var o2Levels: String
    var bloodPressure: String
    var heartRate: String
    
    init(aqi: Int, location: String, date: Date, o2Levels: String, bloodPressure: String, heartRate: String) {
        self.aqi = aqi
        self.location = location
        self.date = date
        self.o2Levels = o2Levels
        self.bloodPressure = bloodPressure
        self.heartRate = heartRate
    }
}
