//
//  DataStore.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/4/25.
//

import Foundation

@Observable
class DataStore : ObservableObject {
    // all extra sorting will be done after these values are computed, and this function is responsible for returning them
    
    // var clientCoordinates : [Double] = getClientCoordinates()
    // call these at the start of the app, if the user doesn't give permission, hence this is empty, we ask for a zipcode/city instead
    var allStores : [Place] = []
    // merged array of nearest and topRated, no duplicates, this is used specifically for the map feature
    
    var nearbyStores : [Place] = []
    var topRatedStores : [Place] = []
    
    private var loading = false
    
    static let shared = DataStore()
    
    private init() {
        print("Datastore initialized")
    }
    // both nearbyStores and topRatedStores are directly from the backend
    
    func bootStrap () async {
        // first thing is client coordinates, do this later
        
        Task {
            do {
                try await performNetworkCalls()
            }
            catch {
                print("Error performing initial network calls")
            }
        }
        // endpoints in a separate file
        // fetch and store nearbyStores, then topRated stores
        // get and store clientCoordinates

    }
    
    func performNetworkCalls() async throws {
        return try await withTaskGroup(of: Void.self) { group in
            group.addTask {
                
            }
            
        }
        
    }
    
    func sort(Filters : [String]) -> [Place] {
        // filters only apply to the nearbyStores array and the topRatedStores array, not the allStores
        // iterate through the filters
        // return the sortedStore
        return [] 
    }
    func getClientCoordinates() -> [Double] {
        // ask permission from client, if not, ask for a zipcode
        return [0,0]
    }
    
}
