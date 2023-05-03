//
//  LocationManager.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/8/23.
//

import Foundation
import MapKit

@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var userLocation: CLLocation?
    @Published var region = MKCoordinateRegion()
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManager() // Singleton: Access this anywhere in app
    
    override init() {
        super.init()
        locationManager.delegate = self // automatically calls functions when specific events occur
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 5280 // 1 mile
    }
    
    // Show location permission alert to user
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
//    func setRegionToUserPosition() {
//        guard let location = userLocation else { return }
//
//        self.region = MKCoordinateRegion(
//            center: location.coordinate,
//            latitudinalMeters: 1000,
//            longitudinalMeters: 1000
//        )
//
//        print("Showing user's location")
//    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    // Gets called when authorization changes (e.g. user allows access, user turns off location)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            // Succesfully allows location
            return
        case .denied, .notDetermined, .restricted:
            // Handle other cases
            return
        @unknown default:
            fatalError("Possible unknown future case")
        }
    }
    
    // Called whenever location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.userLocation = location
    }

}
