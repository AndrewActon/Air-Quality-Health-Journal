//
//  LocationRequestView.swift
//  Air Quality
//
//  Created by Andrew Acton on 2/17/24.
//

import SwiftUI

struct LocationRequestView: View {
    var body: some View {
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            
            VStack {
                Image(systemName: "cloud.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("This app requires permission to access your devices location")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Text("Your location is used only to find local air conditions")
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                Button {
                    LocationManager.shared.requestLocation()
                } label: {
                    Text("Allow Location")
                        .font(.headline)
                        .padding()
                }
                .frame(width: UIScreen.main.bounds.width)
                .padding(.horizontal, -32)
                .background(.green)
                .clipShape(Capsule())
                
                Spacer()
            }
            .foregroundStyle(.white)
         
        }
    }
}

#Preview {
    LocationRequestView()
}
