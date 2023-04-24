//
//  HomeViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation
import MapKit
import SwiftUI
import Combine

// note: cant chain .whereField to get surrounding coordinates
@MainActor
class HomeViewModel: ObservableObject {
    @Published var nearbyGames: [Game] = []
    @Published var showingGamePosted = false
    @Published var gameRepository: GameRepository
    
    // Location
    @Published var locationManager: CLLocationManager?
    @Published var trackingMode = MapUserTrackingMode.follow
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
//    @Published var location: CLLocation?

    private var cancellables = Set<AnyCancellable>()
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
        
        // gameRepository.games republished changes to upcomingGames
        self.gameRepository.$games
            .assign(to: \.nearbyGames, on: self)
            .store(in: &cancellables)
    }
    
    func fetchNearByGames(location: CLLocation) async {        
        let result = await gameRepository.fetchNearByGames(location: location)
        switch result {
        case .success(let games):
            gameRepository.games.append(contentsOf: games)
        case .failure(_):
            return
        }
    }
    
//    func setCameraToUserPosition() {
//        guard let location = location else { return }
//        
//        self.region = MKCoordinateRegion(
//            center: location.coordinate,
//            latitudinalMeters: 1000,
//            longitudinalMeters: 1000
//        )
//    }
}

//extension HomeViewModel {
//    // Call when we create CLLocationManager() and if the user changes permissions
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        
//        self.location = location
//        setCameraToUserPosition()
//    }
//    
//    func checkIfLocationServicesIsEnabled() {
//        // 1. Check if user enabled locations
//        if CLLocationManager.locationServicesEnabled() {
//            print("Location services is enabled")
//            // 2. Check if our app has permission to use user's location
//            locationManager = CLLocationManager() // calls locationManagerDidChangeAuthorization()
//            locationManager?.delegate = self
//        } else {
//            print("Show an alert letting them know this is off and go turn it on")
//        }
//    }
//    
//    private func checkLocationAuthorization() {
//        guard let locationManager = locationManager else {
//            print("location manager not found")
//            return
//        }
//        
//        switch locationManager.authorizationStatus {
//        case .notDetermined: // show popup to ask for permission
//            locationManager.requestWhenInUseAuthorization()
//        case .restricted:
//            print("Your location is restricted likely due to parental controls.")
//        case .denied: // user rejected app
//            print("You have denied this app location permission. Go into settings to change it.")
//        case .authorizedAlways, .authorizedWhenInUse: // user gives permission
//            guard let location = locationManager.location else { return }
//            
//            // User accepts permission to user location
//            self.location = location
//            setCameraToUserPosition()
//            
//            Task {
//                await fetchNearByGames()
//            }
//            break
//        @unknown default:
//            break
//        }
//    }
//}

struct Location: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}
