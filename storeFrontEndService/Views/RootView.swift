//
//  RootView.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/27/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var dataStore : DataStore
    
    var body: some View {
        if(dataStore.storeIsLoading == true) {
            LoadingView()
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


