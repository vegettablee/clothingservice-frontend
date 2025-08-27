//
//  storeFrontEndServiceApp.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/2/25.
//

import SwiftUI


@main
struct storeFrontEndServiceApp: App {
        var body: some Scene {
            
        WindowGroup {
            // network call to fetch all of the needed data, put this into some constant
            
            HomeView()
                .environment(DataStore.shared)
                 
        }
    }
}
