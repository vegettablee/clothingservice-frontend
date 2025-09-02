//
//  RootView.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/27/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var dataStore : DataStore
    @ObservedObject var locationManager : LocationManager
    
    var body: some View {
            if(dataStore.storeIsLoading == true) {
                LoadingView().task {
                    dataStore.start(lat: locationManager.getLatitude(), lon: locationManager.getLongitude()) // starts all of the main network calls
                }
            }
            else {
                StoreInfoTemplateView().onAppear() {
                    Task {
                        try await dataStore.performPhotoNetworkCalls()
                    }
                }
            }
    }
}


