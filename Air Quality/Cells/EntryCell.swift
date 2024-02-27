//
//  EntryCell.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/27/24.
//

import SwiftUI

struct EntryCell: View {
    @EnvironmentObject var homeScreenViewModel: HomeScreenViewModel
    let entry: JournalEntry
    
    var body: some View {
        HStack {
            Text(entry.date, format: .dateTime.year().month(.abbreviated).day())
                .multilineTextAlignment(.center)
            
            Text(entry.location)
            
            ZStack {
                Circle()
                    .foregroundStyle(homeScreenViewModel.checkQualityOfAir(aqi: entry.aqi))
                    .frame(width: 36)
                
                Text("\(entry.aqi)")
                    .font(.system(size: 20))
                    .foregroundStyle(.white)
            }
        }
    }
}

