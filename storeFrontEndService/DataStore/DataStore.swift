//
//  DataStore.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/4/25.
//

import Foundation

@MainActor
@Observable
class DataStore : ObservableObject {
    // all extra sorting will be done after these values are computed, and this function is responsible for returning them
    
    // var clientCoordinates : [Double] = getClientCoordinates()
    // call these at the start of the app, if the user doesn't give permission, hence this is empty, we ask for a zipcode/city instead
    var allStores : [Place] = []
    // merged array of nearest and topRated, no duplicates, this is used specifically for the map feature
    
    var nearbyStores : [Place] = []
    var topRatedStores : [Place] = []
    
    var storeIsLoading = true
    var photosAreLoading = true
    
    var latitude : Double?
    var longitude : Double?
    
    static let shared = DataStore()
    
    private init() {
        print("DataStore initialized without bootstrap...")
    }
    
    func start (lat : Double, lon : Double)  {
        self.latitude = lat
        self.longitude = lon
     // this only runs once the user's location has been enabled, and the coordinates exist
        Task {
            await bootStrap()
            print("Datastore filled")
        }
    }
    // both nearbyStores and topRatedStores are directly from the backend
    
    func bootStrap () async {
        // first thing is client coordinates, do this later
        
        Task {
            do {
                try await performNetworkCalls()
            }
            catch {
                print("Error performing initial network calls", error)
            }
        }
        // endpoints in a separate file
        // fetch and store nearbyStores, then topRated stores
        // get and store clientCoordinates

    }
    
    func performNetworkCalls() async throws {
        async let nearby = await NetworkManager.shared.fetchNearbyStores(lat : self.latitude!, lon : self.longitude!)
        async let top = await NetworkManager.shared.fetchTopRatedStores(lat : self.latitude!, lon : self.longitude!)
        
        let (n, t) = await (nearby, top)
        self.nearbyStores = n
        self.topRatedStores = t
        self.storeIsLoading = false
    }
    
    func updateStorePhotoUris (type : String, index : Int, photoUris : [String] ) async {
        if(type == "NEARBY") {
            self.nearbyStores[index].photoURIs = photoUris
        }
        else if(type == "TOPRATED") {
            self.topRatedStores[index].photoURIs = photoUris
        }
    }
    
    func performPhotoNetworkCalls() async throws {
        
        try await withThrowingTaskGroup(of: [String].self) { group in
            for index in 0..<self.nearbyStores.count {
                group.addTask {
                    if let photos = await self.nearbyStores[index].photos {
                        // pass in the index
                        let photoUris = await NetworkManager.shared.getStorePhotos(storePhotoKey: photos[0].s3Key ?? "")
                        await self.updateStorePhotoUris(type: "NEARBY", index: index, photoUris: photoUris)
                       //  self.nearbyStores[index].photoURIs = photoUris
                        return photoUris
                    }
                    else {
                        return [""]
                    }
                }
            }
            for index in 0..<self.topRatedStores.count {
                group.addTask {
                    if let photos = await self.topRatedStores[index].photos {
                        let photoUris = await NetworkManager.shared.getStorePhotos(storePhotoKey: photos[0].s3Key ?? "")
                        await self.updateStorePhotoUris(type: "TOPRATED", index: index, photoUris: photoUris)
                        return photoUris
                    }
                    else {
                        return [""]
                    }
                }
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
