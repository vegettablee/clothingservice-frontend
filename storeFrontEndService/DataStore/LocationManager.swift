//
//  LocationManager.swift
//  storeFrontEndService
//
//  Created by Preston Rank on 8/29/25.
//

import Foundation
import MapKit


class LocationManager : NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager : CLLocationManager?
    @Published var locationIsLoaded = false
    @Published var locationDenied = false
    @Published var authStatus : CLAuthorizationStatus = .notDetermined
    @Published var location : CLLocation?
    
    static let shared = LocationManager()
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        authStatus = locationManager?.authorizationStatus ?? .notDetermined
    }
    
    func checkIfLocationIsEnabled () {
        if(authStatus != .authorizedAlways && authStatus != .authorizedWhenInUse) {
            print("Location services must be enabled to use this application")
            locationManager?.requestWhenInUseAuthorization()
        }
        
    }
    
    
    func getLatitude () -> Double {
        if let latitude = location?.coordinate.latitude {
            return latitude
        }
        else {
            print("Error fetching latitude")
            return 0
        }
       
    }
    func getLongitude () -> Double {
        if let longitude = location?.coordinate.longitude {
            return longitude
        }
        else {
            print("Error fetching longitude")
            return 0
        }
    }
    func requestLocation()  {
        locationManager?.startUpdatingLocation()
    }
    
    func checkLocationAuthorization () {
        guard let locationManager = locationManager else { return }
        
        authStatus = locationManager.authorizationStatus
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("You have restricted location services")
        case .denied:
            self.locationDenied = true
            print("Location permission denied, app cannot run without location")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
            
            // put code here to set off the proper loading screen
            
            
        @unknown default:
            fatalError()
        }
    }
    
    @objc func locationManagerDidChangeAuthorization(_ manager : CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        
        DispatchQueue.main.async {
                self.location = latestLocation
                self.locationIsLoaded = true
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
    }
    
    
}

