import Foundation

// let lat = 33.066262; // lat, lon, rad, are all dummy data for now, client should have them
// let lon = -96.73098;
let rad = 8000;
// let URL = "http://localhost:3000/stores/nearby"

// { longitude, latitude, radius } are the query parameters
// fetchNearby Stores endpoint
// topRatedStores endpoint

let PORT = 3000;
let SCHEME = "http"
let HOST = "localhost"
let nearbyPath = "/stores/nearby"
let topRatedPath = "/stores/toprated"


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        print("Network manager initialized")
    }
    
    func fetchNearbyStores(lat : Double, lon : Double) async -> [Place] { // add longitude, latitude, and radius later as parameters
        
        print("Created request for nearbyStores endopint...")
        var urlComponents = URLComponents()
        
        urlComponents.port = PORT
        urlComponents.scheme = SCHEME
        urlComponents.host = HOST
        urlComponents.path = nearbyPath
        
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "longitude", value: String(lon)))
        queryItems.append(URLQueryItem(name: "latitude", value: String(lat)))
        queryItems.append(URLQueryItem(name: "radius", value: String(rad)))
        
        urlComponents.queryItems = queryItems
        
        let url = URLRequest(url: urlComponents.url!)
        
        print("This is the url : ", urlComponents.url!)
        
        let nearbyStores : [Place] = await sendNetworkRequest(url: url)
        //DataStore.shared.nearbyStores = nearbyStores
        print("nearbyStores saved to DataStore...")
        return nearbyStores
        
    }
    
    func fetchTopRatedStores(lat : Double, lon : Double) async -> [Place] { // add longitude, latitude, and radius later as parameters
        
        print("Creating request for topRatedStores endpoint...")
        var urlComponents = URLComponents()
        
        urlComponents.port = PORT
        urlComponents.scheme = SCHEME
        urlComponents.host = HOST
        urlComponents.path = topRatedPath
        
        var queryItems : [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "longitude", value: String(lon)))
        queryItems.append(URLQueryItem(name: "latitude", value: String(lat)))
        queryItems.append(URLQueryItem(name: "radius", value: String(rad)))
        
        urlComponents.queryItems = queryItems
        
        let url = URLRequest(url: urlComponents.url!) // force unwrap for now
        
        print("This is the url : ", urlComponents.url!)
        
        let topRatedStores : [Place] = await sendNetworkRequest(url: url)
       // DataStore.shared.topRatedStores = topRatedStores
        print("topRated stores saved to DataStore...")
        return topRatedStores
    }
    
    
    
    func sendNetworkRequest(url: URLRequest) async -> [Place] {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60

        let session = URLSession(configuration: configuration)

        do {
            let (data, response) = try await session.data(for: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Unexpected response:", response)
                return []
            }
            let decoder = JSONDecoder()
            return try decoder.decode([Place].self, from: data)
        } catch {
            print("Error during network request:", error)
            return []
        }
    }
    
    func getStorePhotos(storePhotoKey : String) async -> [String] { // this works
        
        guard let url = URL(string : Constants.s3PhotosEndpoint + "?baseKey=" + storePhotoKey) else {
            print("Error with storePhotos endpoint URL")
            return [""]
        }
        
        print("baseKey : " + storePhotoKey)
        do {
            let (data, response) = try await URLSession.shared.data(from : url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error with http response")
                return [""]
            }
            
            if(httpResponse.statusCode == 200) {
                print("Fetching store photos successful for storePhotoKey : " + storePhotoKey)
                typealias photoURIs = [String]
                
                let decoder = JSONDecoder()
                let photoUris = try decoder.decode(photoURIs.self, from : data)
                print("Received photoURIs for : " + storePhotoKey)
                
                return photoUris
                
            }
            else { // code is not 200
                print("Server returned with status code : " + String(httpResponse.statusCode))
                return [""]
            }
        }
        catch {
            print("Error getting store photos, returning [","], ")
        }
        return [""]
    }
}
// Entry point for the executable
