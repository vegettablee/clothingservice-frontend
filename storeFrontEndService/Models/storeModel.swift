import Foundation

// MARK: - Supporting Models


struct AuthorAttribution: Codable {
    let displayName: String?
    let uri: String?
    let photoUri: String?
}

struct Photo: Codable {
    let id: String?
    let name: String?
    let widthPx: Int?
    let heightPx: Int?
    let s3Key: String?
    let googleMapsUri: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, widthPx, heightPx, s3Key, googleMapsUri
    }
}

struct ReviewText: Codable {
    let text: String?
    let languageCode: String?
}

struct Review: Codable {
    let name: String?
    let relativePublishTimeDescription: String?
    let rating: Double?
    let text: ReviewText?
    let originalText: ReviewText?
    let authorAttribution: AuthorAttribution?
    let publishTime: String?
    let flagContentUri: String?
    let googleMapsUri: String?
}

struct GenerativeSummaryText: Codable {
    let text: String?
    let languageCode: String?
}

struct GenerativeSummary: Codable {
    let overview: GenerativeSummaryText?
    let overviewFlagContentUri: String?
    let disclosureText: GenerativeSummaryText?
}

struct DisplayName: Codable {
    let text: String
    let languageCode: String
}

struct Location: Codable {
    let type: String
    let coordinates: [Double] // [longitude, latitude]
    
    var longitude: Double {
        return coordinates.count >= 2 ? coordinates[0] : 0.0
    }
    
    var latitude: Double {
        return coordinates.count >= 2 ? coordinates[1] : 0.0
    }
}

// MARK: - Main Place Model

struct Place: Decodable {
    let mongoId: String?
    let id: String // Google Place ID
    let displayName: DisplayName
    let location: Location
    let shortFormattedAddress: String?
    let websiteUri: String?
    let rating: Double?
    let userRatingCount: Int?
    let reviews: [Review]?
    let photos: [Photo]?
    let generativeSummary: GenerativeSummary?
    let primary: [String]
    let funding: [String]
    let inventory: [String]
    let summary: String
    let hasSecondhandClothing: Bool
    var photoURIs : [String]?
    
    enum CodingKeys: String, CodingKey {
        case mongoId = "_id"
        case id, displayName, location, shortFormattedAddress
        case websiteUri, rating, userRatingCount, reviews, photos
        case generativeSummary
        case primary = "Primary"
        case funding = "Funding"
        case inventory = "Inventory"
        case summary = "Summary"
        case hasSecondhandClothing
    }
}

// MARK: - Convenience Extensions

extension Place {
    var coordinate: (latitude: Double, longitude: Double) {
        return (latitude: location.latitude, longitude: location.longitude)
    }
    
    var averageRating: Double {
        return rating ?? 0.0
    }
    
    var reviewCount: Int {
        return userRatingCount ?? 0
    }
}

// MARK: - Sample Usage

/*
// Example of decoding from JSON
let jsonData = Data(contentsOfFile: "place.json")
let decoder = JSONDecoder()
let place = try decoder.decode(Place.self, from: jsonData)

// Example of encoding to JSON
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
let jsonData = try encoder.encode(place)
*/


struct Store : Identifiable {
    let id : UUID = UUID()
    let name : String = "Thrift Store"
    
    let rating : Double = 4.7
    let userRatingCount : Int = 281
    
    let inventory : String = "Mall/Trendy"
}
