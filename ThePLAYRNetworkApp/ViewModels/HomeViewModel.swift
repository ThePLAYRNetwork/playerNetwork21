//
//  HomeViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation
import MapKit
import SwiftUI

// note: cant chain .whereField to get surrounding coordinates
@MainActor
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var gameRepository: GameRepository
    @Published var upcomingGames: [Game] = Game.sampleGames

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published private var locationManager: CLLocationManager?
    @Published var path = NavigationPath()
    @Published var showingGamePosted = false
    @Published var trackingMode = MapUserTrackingMode.follow

    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
    }
    
    func fetchNearByGames() async -> [Game] {
        return await gameRepository.fetchNearByGames()
    }
    
}

extension HomeViewModel {
    func checkIfLocationServicesIsEnabled() {
        // 1. Check if user enabled locations
        if CLLocationManager.locationServicesEnabled() {
            // 2. Check if our app has permission to use user's location
            locationManager = CLLocationManager() // calls locationManagerDidChangeAuthorization()
            locationManager?.delegate = self
        } else {
            print("Show an alert letting them know this is off and go turn it on")
        }
    }
    
    // this func gets call when we create CLLocationManager() and if the user changes permissions
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined: // show popup to ask for permission
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied: // user rejected app
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse: // user gives permission
            // Set camera to user's location
            region = MKCoordinateRegion(
                center: locationManager.location!.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            // fetch nearby markers
//            fetchNearbyLocations()
            break
        @unknown default:
            break
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}
