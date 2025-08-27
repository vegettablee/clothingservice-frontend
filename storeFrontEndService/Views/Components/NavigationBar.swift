import SwiftUI

// Main navigation tabs - no longer using global constant

// View for main navigation tabs
struct HorizontalItemsView: View {
    var body: some View {
        TabView {
            // Home Tab - Minimal invisible content that still registers as a view
            Color.clear
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            
            // Search Tab - Minimal invisible content that still registers as a view
            Color.clear
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Map")
                }
                .tag(1)
            // Favorites Tab - Minimal invisible content that still registers as a view
            Color.clear
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
                .tag(2)
            
            // Profile Tab - Minimal invisible content that still registers as a view
            Color.clear
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(3)
        }
        .tabViewStyle(DefaultTabViewStyle())
        .frame(maxWidth: .infinity, maxHeight : 50)

    }
}
