import Foundation
import SwiftUI

struct HorizontalPlaceholderSection: View {
    
    static let storePageSize : Int = 10 // number of stores loaded before needing a refresh
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(0..<10) { index in
                    storeItem()
                      //  .background(Color.gray)
                }
            }
            //.padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: 215)
        .clipped(antialiased: false) // Disables scroll clipping for seamless appearance
  //      .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.vertical, 5)
    }
}

struct storeItem : View {
    
    // Font constants for easy customization
    private static let primaryFont = "SF Pro Display"
    private static let storeName: Font = .custom(primaryFont, size: 16).weight(.medium)
    private static let ratingText: Font = .custom(primaryFont, size: 12).weight(.medium)
    private static let userCount: Font = .custom(primaryFont, size: 11)
    private static let inventoryText: Font = .custom(primaryFont, size: 11)
    
    @State var store = Store()
    
    var body : some View {
        VStack(spacing: 0) {
            // Image section (60% of the view)
            URLImageView("https://www.google.com/maps/place//data=!3m4!1e2!3m2!1sCIHM0ogKEICAgICRydCQ7gE!2e10!4m2!3m1!1s0x864c23d935eba4b9:0xfc6c3e533c8c4d20")
               // .fill(Color.blue.opacity(0.3))
                .frame(width: 140, height: 129) // 60% of total height (215 * 0.6)
                .overlay(
                    Image(systemName: "photo")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                )
            
            // Metadata section (40% of the view)
            VStack(alignment: .leading, spacing: 4) {
                // 1st line: Store name
                Text(store.name)
                    .font(Self.storeName)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // 2nd line: Rating, stars, and user count
                HStack(spacing: 4) {
                    Text(String(format: "%.1f", store.rating))
                        .font(Self.ratingText)
                        .foregroundColor(.primary)
                    
                    StarRatingView(rating: store.rating)
                        .frame(height: 12)
                    
                    Text("(\(store.userRatingCount))")
                        .font(Self.userCount)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                // 3rd line: Inventory
                Text("Sells: " + store.inventory)
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
        .background(Color.gray)
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
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


