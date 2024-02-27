//
//  JournalViewModel.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/27/24.
//

import SwiftUI

@MainActor class JournalViewModel: ObservableObject {
    
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
        case 300...900:
            return Color(Color.black)
        default:
            return Color(Color.blue)
        }
    }
}

