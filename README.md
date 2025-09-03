## Overview
Native iOS frontend for the Geospatial Thrift Store Discovery platform, built with SwiftUI and MapKit for location-based store exploration.

## Features
Home Dashboard: Clean interface displaying nearby thrift stores based on user location
Location Services: Automatic proximity detection for store recommendations
Store Details: Detailed views with store information, hours, and contact details

## Architecture
User Location → Location Services → API Request → Store Data → Display
The app uses native iOS location services to get user coordinates, makes requests to the backend API, and displays results through both a dashboard view and interactive map interface.

Tech Stack
SwiftUI, MapKit, CoreLocation, URLSession

Key Components
ContentView.swift - Main stores screen, includes all nearby stores as well as top rated stores. 
DataStore.swift - Bootstrap file, handles lifecycle of the app and startup network calls.
LocationManager.swift - location manager file, all changes to location are handled here.

## Setup
Clone repository
Open .xcodeproj in Xcode
Ensure location permissions are configured in Info.plist
Build and run on simulator or device

## Requirements
iOS 14.0+
Xcode 12+
Location services enabled
