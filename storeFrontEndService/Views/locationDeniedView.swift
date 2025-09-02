//
//  LocationPermissionView.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/27/25.
//

import Foundation
import SwiftUI

struct LocationPermissionView: View {
    @ObservedObject var locationManager : LocationManager
    
    var body: some View {
        ZStack {
            // White background
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Location icon
                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.1))
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "location.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.orange)
                }
                
                VStack(spacing: 16) {
                    // Main title
                    Text("Location Access Required")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                    
                    // Description text
                    Text("This app needs access to your location to find nearby stores and provide you with the best shopping experience.")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                // Enable Location button
                Button(action: {
                    if(locationManager.locationDenied == true) {
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    }
                    else {
                        locationManager.requestLocation()
                    }
                    // Add your location permission logic here
                }) {
                    HStack {
                        Image(systemName: "location.fill")
                            .font(.system(size: 16, weight: .medium))
                        Text("Enable Location")
                            .font(.system(size: 18, weight: .medium))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.orange)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
                }
            }
        }
    }
}

// Preview
/*
 struct LocationPermissionView_Previews: PreviewProvider {
 static var previews: some View {
 LocationPermissionView()
 }
 }
 */
