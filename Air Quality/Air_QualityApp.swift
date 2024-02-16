//
//  Air_QualityApp.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/16/24.
//

import SwiftUI

@main
struct Air_QualityApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
