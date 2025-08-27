import SwiftUI

// MARK: - Home Screen
struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                // Header Section
                VStack(spacing: 10) {
                    Image(systemName: "house.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Welcome Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Your app starts here")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 50)
                
                Spacer()
                
                // Main Content Area
                VStack(spacing: 20) {
                    
                    // Feature Cards
                    HStack(spacing: 15) {
                        FeatureCard(
                            icon: "star.fill",
                            title: "Featured",
                            color: .orange
                        )
                        
                        FeatureCard(
                            icon: "heart.fill",
                            title: "Favorites",
                            color: .red
                        )
                    }
                    
                    HStack(spacing: 15) {
                        FeatureCard(
                            icon: "person.fill",
                            title: "Profile",
                            color: .green
                        )
                        
                        FeatureCard(
                            icon: "gearshape.fill",
                            title: "Settings",
                            color: .gray
                        )
                    }
                }
                
                Spacer()
                
                // Navigation Button
                NavigationLink(destination:  StoreInfoTemplateView()) {
                    HStack {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title2)
                        Text("Go to Next Screen")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Feature Card Component
struct FeatureCard: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - Second Screen (Placeholder)
struct SecondView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Second Screen")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("You successfully navigated!")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Second Screen")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
