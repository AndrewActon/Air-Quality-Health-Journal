//
//  InfoView.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/26/24.
//

import SwiftUI

struct InfoView: View {
    @GestureState private var aqiZoom = 1.0
    
    var body: some View {
        VStack {
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
        .background()
        .shadow(radius: 12)
        .clipShape(Rectangle())
    }
}

#Preview {
    InfoView()
}
