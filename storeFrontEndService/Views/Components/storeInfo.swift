import Foundation
import SwiftUI

struct HorizontalPlaceholderSection: View {
    
    static let storePageSize : Int = 10 // number of stores loaded before needing a refresh
    @Binding var stores : [Place]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<stores.count) { index in
                    storeItem(store: $stores[index]).onTapGesture {
                        
                    }
                      //  .background(Color.gray)
                }
            }
            //.padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: 215)
        .clipped(antialiased: false) // Disables scroll clipping for seamless appearance
  //      .background(Color(.systemGray6))
        .cornerRadius(4)
        .padding(.vertical, 5)
    }
}

struct storeItem : View {
    
    // Font constants for easy customization
    private static let primaryFont = "SF Pro Display"
    private static let storeName: Font = .custom(primaryFont, size: 14).weight(.medium) // Reduced from 16
    private static let categoryText: Font = .custom(primaryFont, size: 10) // New category font
    private static let ratingText: Font = .custom(primaryFont, size: 12).weight(.medium)
    private static let userCount: Font = .custom(primaryFont, size: 11)
    private static let inventoryText: Font = .custom(primaryFont, size: 11)
   // @State var store : Place
    
    @Binding var store : Place
    
    var body : some View {
        VStack(spacing: 0) {
            // Image section (60% of the view)
            URLImageView(store.photoURIs?[0] ?? "")
               // .fill(Color.blue.opacity(0.3))
                .frame(width: 140, height: 129) // 60% of total height (215 * 0.6)
                .clipped()
                .cornerRadius(8, corners: [.topLeft, .topRight]) // Apply corner radius only to top corners
            /*
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                )
             */
            
            // Metadata section (40% of the view)
            VStack(alignment: .leading, spacing: 3) { // Reduced spacing from 4 to 3
                // 1st line: Store name (smaller font)
                Text(store.displayName.text)
                    .font(Self.storeName)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 2nd line: Category field
                Text("Category: ")
                    .font(Self.categoryText)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 3rd line: Rating, stars, and user count
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
                
                // 4th line: Inventory
                Text("Sells: " + store.inventory.joined(separator: ", "))
                    .font(Self.inventoryText)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .frame(width: 140, height: 86) // 40% of total height
        }
        .frame(width: 140, height: 215)
        .background(Color.clear)
        .cornerRadius(8)
      //  .shadow(color : Color.black, radius: 15)
        
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


