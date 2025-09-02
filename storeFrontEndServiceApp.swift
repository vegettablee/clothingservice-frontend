//
//  storeFrontEndServiceApp.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/2/25.
//

import SwiftUI


@main
struct storeFrontEndServiceApp: App {
    @StateObject private var dataStore = DataStore.shared
    @StateObject private var locationManager = LocationManager.shared
    
    var body: some Scene {
        WindowGroup {
            // only present the store view if the location is enabled
            if(locationManager.locationIsLoaded == true && locationManager.locationDenied == false) {
                RootView(locationManager: locationManager)
                    .environmentObject(dataStore)
            }
            else {
            // permission loading screen, redirects user back to settings to enable location services
                LocationPermissionView(locationManager: locationManager).onAppear() {
                    locationManager.checkIfLocationIsEnabled()
                }
            }
        }
    }
}
