import Foundation

// MARK: - Nested helper types

/// Matches `{ text: String, languageCode: String }`
struct LocalizedText: Codable {
    let text: String
    let languageCode: String
}

/// Matches the GeoJSON “Point” object
struct GeoJSONPoint: Codable {
    let type: String         // always "Point"
    let coordinates: [Double] // [longitude, latitude]
}

/// { displayName, uri, photoUri }
struct AuthorAttribution: Codable {
    let displayName: String
    let uri: String
    let photoUri: String
}

/// { name, widthPx, heightPx, s3Key, googleMapsUri }
struct Photo: Codable {
    let name: String
    let widthPx: Int
    let heightPx: Int
    let s3Key: String
    let googleMapsUri: String
}

/// { text, languageCode }
struct ReviewText: Codable {
    let text: String
    let languageCode: String
}

/// Full review block
struct Review: Codable {
    let name: String
    let relativePublishTimeDescription: String
    let rating: Int
    let text: ReviewText
    let originalText: ReviewText
    let authorAttribution: AuthorAttribution?
    let publishTime: String
    let flagContentUri: String?
    let googleMapsUri: String?
}

/// { overview, overviewFlagContentUri, disclosureText }
struct GenerativeSummary: Codable {
    let overview: ReviewText
    let overviewFlagContentUri: String?
    let disclosureText: ReviewText
}

// MARK: - Top‐level Place

struct Place: Identifiable { // add codable later
    // from `id: { type: String, required: true }`
    let id : UUID = UUID()

    let displayName : String = "Thrift Store" // replace to localizedText later
    // let location: GeoJSONPoint

 //   let shortFormattedAddress: String?
    let websiteUri: String = "thriftstore.com"
    let rating: Double = 4.8
    let userRatingCount: Int = 281

    //let reviews: [Review]?
    //let photos: [Photo]?
    //let generativeSummary: GenerativeSummary?

    // your custom fields
    //let primary: String?
    // let funding: String?
   // let inventory: String?
    // let summary: String?
    //let hasSecondhandClothing: Bool?

    // If your JSON keys don’t exactly match these Swift names,
    // you can add a CodingKeys enum here to map them.
}

struct Store : Identifiable {
    let id : UUID = UUID()
    let name : String = "Thrift Store"
    
    let rating : Double = 4.7
    let userRatingCount : Int = 281
    
    let inventory : String = "Mall/Trendy"
}
