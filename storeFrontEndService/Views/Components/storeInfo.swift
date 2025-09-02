import Foundation
import SwiftUI

struct HorizontalPlaceholderSection: View {
    static let storePageSize: Int = 10
    @Binding var stores: [Place]
    
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(stores.indices, id: \.self) { index in
                    storeItem(store: $stores[index])
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 215)
        .clipped(antialiased: false)
        .cornerRadius(4)
        .padding(.vertical, 5)
        .fullScreenCover(
            isPresented: Binding(
                get: { selectedIndex != nil },
                set: { if !$0 { selectedIndex = nil } }
            )
        ) {
            if let index = selectedIndex {
                StoreMetadataView(place: $stores[index])
                    .interactiveDismissDisabled(false)
                    .scrollDismissesKeyboard(.interactively)// ✅ binding still works
            }
        }
    }
}



struct storeItem : View {
    // Font constants for easy customization
    private static let primaryFont = "SF Pro Display"
    private static let storeName: Font = .custom(primaryFont, size: 14).weight(.medium)
    private static let categoryText: Font = .custom(primaryFont, size: 10)
    private static let ratingText: Font = .custom(primaryFont, size: 12).weight(.medium)
    private static let userCount: Font = .custom(primaryFont, size: 11)
    private static let inventoryText: Font = .custom(primaryFont, size: 11)

    @Binding var store : Place

    var body : some View {
        VStack(spacing: 0) {
            // ⭐️ Safe: use .first instead of [0]
            URLImageView(store.photoURIs?.first ?? "")
                .frame(width: 140, height: 129)
                .clipped()
                .cornerRadius(8, corners: [.topLeft, .topRight])

            // Metadata section (40% of the view)
            VStack(alignment: .leading, spacing: 3) {
                Text(store.displayName.text)
                    .font(Self.storeName)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("Category: " + (store.primary?.first ?? "Not available"))
                    .font(Self.categoryText)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 4) {
                    Text(String(format: "%.1f", store.rating ?? 0))
                        .font(Self.ratingText)
                        .foregroundColor(.primary)

                    StarRatingView(rating: store.rating ?? 0)
                        .frame(height: 12)

                    Text("(\(store.userRatingCount ?? 0))")
                        .font(Self.userCount)
                        .foregroundColor(.secondary)

                    Spacer()
                }

                Text("Sells: " + store.inventory.joined(separator: ", "))
                    .font(Self.inventoryText)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .frame(width: 140, height: 86)
        }
        .frame(width: 140, height: 215)
        .background(Color.clear)
        .cornerRadius(8)
    }
}


// Extension to apply corner radius to specific corners
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

struct StarRatingView: View {
    let rating: Double
    private let maxRating: Int = 5
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { index in
                StarView(
                    fillPercentage: starFillPercentage(for: index)
                )
            }
        }
    }
    
    private func starFillPercentage(for starIndex: Int) -> Double {
        let starPosition = Double(starIndex)
        
        if rating >= starPosition {
            return 1.0 // Fully filled
        } else if rating > starPosition - 1 {
            return rating - (starPosition - 1) // Partially filled
        } else {
            return 0.0 // Empty
        }
    }
}

struct StarView: View {
    let fillPercentage: Double
    
    var body: some View {
        ZStack {
            // Background star (empty)
            Image(systemName: "star")
                .font(.system(size: 10))
                .foregroundColor(.gray.opacity(0.3))
            
            // Filled star with mask for partial filling
            Image(systemName: "star.fill")
                .font(.system(size: 10))
                .foregroundColor(.yellow)
                .mask(
                    HStack {
                        Rectangle()
                            .frame(width: CGFloat(fillPercentage) * 10)
                        Spacer(minLength: 0)
                    }
                )
        }
        .frame(width: 10, height: 10)
    }
}


