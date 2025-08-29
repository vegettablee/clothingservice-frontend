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
        var body: some Scene {
            WindowGroup {
                    RootView()
                        .environmentObject(dataStore)
            }
    }
}
