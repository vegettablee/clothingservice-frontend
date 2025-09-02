//
//  StoreMetadataView.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 9/1/25.
//

import Foundation
import SwiftUI

struct StoreMetadataView: View {
    @Binding var place: Place
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Dismiss button
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // Store header with title leading and rating/reviews trailing
                HStack {
                    // Store name (leading aligned)
                    Text(place.displayName.text)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    // Rating, star, and review count (trailing aligned)
                    HStack(spacing: 4) {
                        // Review count in parentheses
                        Text("(\(place.userRatingCount ?? 0))")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        // Rating
                        Text(String(format: "%.1f", place.rating ?? 0.0))
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        // Star
                        Image(systemName: "star.fill")
                            .font(.system(size: 16))
                            .foregroundColor(.orange)
                    }
                }
                .padding(.horizontal, 20)
                
                // Scrollable photo gallery - guard against nil/empty photoURIs
                
                if let photoURIs = place.photoURIs, !photoURIs.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(photoURIs.enumerated()), id: \.offset) { index, photoUri in
                                AsyncImage(url: URL(string: photoUri)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 144, height: 144)
                                        .clipped()
                                        .cornerRadius(12)
                                } placeholder: {
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.orange.opacity(0.1))
                                        .frame(width: 144, height: 144)
                                        .overlay(
                                            Image(systemName: "photo")
                                                .font(.system(size: 24))
                                                .foregroundColor(.orange.opacity(0.6))
                                        )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                } else {
                    // Placeholder when no photos available
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(0..<3, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.orange.opacity(0.1))
                                    .frame(width: 144, height: 144)
                                    .overlay(
                                        Image(systemName: "photo")
                                            .font(.system(size: 24))
                                            .foregroundColor(.orange.opacity(0.6))
                                    )
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                // Category section - guard against empty arrays (primary categories only)
                if let primary = place.primary, !primary.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Category :")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        // Flexible wrapping layout for categories with fixed width
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 120), spacing: 8)
                        ], alignment: .leading, spacing: 8) {
                            ForEach(Array(primary.enumerated()), id: \.offset) { index, category in
                                Text(category)
                                    .font(.system(size: 14, weight: .medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 120, minHeight: 32)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.orange.opacity(0.1))
                                    .foregroundColor(.orange)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                // Inventory section with darker orange
                if !place.inventory.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Inventory :")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        // Flexible wrapping layout for inventory with fixed width
                        LazyVGrid(columns: [
                            GridItem(.adaptive(minimum: 120), spacing: 8)
                        ], alignment: .leading, spacing: 8) {
                            ForEach(Array(place.inventory.enumerated()), id: \.offset) { index, item in
                                Text(item)
                                    .font(.system(size: 14, weight: .medium))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .multilineTextAlignment(.center)
                                    .frame(minWidth: 120, minHeight: 32)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.orange.opacity(0.3))
                                    .foregroundColor(.orange)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                // Description section using summary - summary is non-optional
                VStack(alignment: .leading, spacing: 8) {
                    Text("Description")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(place.summary)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.secondary)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                }
                .padding(.horizontal, 20)
                
                // Funding section - displays single funding type
                VStack(alignment: .leading, spacing: 8) {
                    Text("Funding :")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    HStack {
                        // Replace with your actual funding variable, e.g. place.fundingType
                        Text("Purchase-based") // Replace this with your funding variable
                            .font(.system(size: 14, weight: .medium))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(8)
                        
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                
                // Reviews section - guard against nil/empty reviews array
                if let reviews = place.reviews, !reviews.isEmpty {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Reviews")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Array(reviews.enumerated()), id: \.offset) { index, review in
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            // Star rating - guard against nil rating
                                            if let rating = review.rating {
                                                let starCount = max(0, min(5, Int(rating.rounded())))
                                                HStack(spacing: 2) {
                                                    ForEach(0..<starCount, id: \.self) { _ in
                                                        Image(systemName: "star.fill")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.orange)
                                                    }
                                                    ForEach(starCount..<5, id: \.self) { _ in
                                                        Image(systemName: "star")
                                                            .font(.system(size: 12))
                                                            .foregroundColor(.gray.opacity(0.4))
                                                    }
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        // Reviewer name and publish time - guard against nil values
                                        VStack(alignment: .leading, spacing: 2) {
                                            if let authorName = review.authorAttribution?.displayName {
                                                Text(authorName)
                                                    .font(.system(size: 14, weight: .medium))
                                                    .foregroundColor(.secondary)
                                            }
                                            if let publishTime = review.relativePublishTimeDescription {
                                                Text(publishTime)
                                                    .font(.system(size: 12, weight: .regular))
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        
                                        // Review text - guard against nil text
                                        if let reviewText = review.text?.text, !reviewText.isEmpty {
                                            Text(reviewText)
                                                .font(.system(size: 15, weight: .regular))
                                                .foregroundColor(.primary)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(4)
                                        }
                                    }
                                    .frame(width: 250)
                                    .padding(16)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .shadow(color: .gray.opacity(0.1), radius: 2, x: 0, y: 1)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 20)
                } else {
                    // Placeholder when no reviews available
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Reviews")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 20)
                        
                        Text("No reviews available yet.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 20)
                    }
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
}
