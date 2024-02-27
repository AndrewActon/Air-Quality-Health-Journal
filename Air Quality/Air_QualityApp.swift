//
//  Air_QualityApp.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/16/24.
//

import SwiftUI
import SwiftData

@main
struct Air_QualityApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [JournalEntry.self])
    }
}
