//
//  HomeViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation
import FirebaseFirestore
import MapKit
import GeoFire
import FirebaseAuth
import SwiftUI

// note: cant chain .whereField to get surrounding coordinates
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var upcomingGames: [Game] = []
    @Published var locations: [Location] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @Published var showingGamePosted = false
    @Published private var locationManager: CLLocationManager?
    private var db = Firestore.firestore()
    
    @Published var path = NavigationPath()
    
    func fetchNearbyLocations() {
        guard let locationManager = locationManager else {
            return
        }
        // Find cities within 50km of user
        guard let center = locationManager.location?.coordinate else {
            return
        }
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        // Clear previous markers
        self.locations.removeAll()
        self.upcomingGames.removeAll()

        let radiusInM: Double = 50 * 1000
        
        let queryBounds = GFUtils.queryBounds(forLocation: center,
                                              withRadius: radiusInM)
        let queries = queryBounds.map { bound in
            return db.collection("games")
                .order(by: "geohash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
        
        
        // Collect all the query results together into a single list
        func getDocumentsCompletion(snapshot: QuerySnapshot?, error: Error?) -> () {
            guard let documents = snapshot?.documents else {
                print("Unable to fetch snapshot data. \(String(describing: error))")
                return
            }

            for document in documents {
                guard let game = try? document.data(as: Game.self) else {
                    return
                }
                let coordinates = CLLocation(latitude: game.latitude, longitude: game.longitude)
                let centerPoint = CLLocation(latitude: center.latitude, longitude: center.longitude)

                // We have to filter out a few false positives due to GeoHash accuracy, but
                // most will match
                let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                if distance <= radiusInM {
                    // add games that belong to user
                    if game.creatorID == uid {
                        self.upcomingGames.append(game)
                    }
                    self.locations.append(Location(name: game.title, coordinate: CLLocationCoordinate2D(latitude: game.latitude, longitude: game.longitude)))
                }
            }
        }

        // After all callbacks have executed, matchingDocs contains the result. Note that this
        // sample does not demonstrate how to wait on all callbacks to complete.
        for query in queries {
            print("querying")
            query.getDocuments(completion: getDocumentsCompletion)
        }
    }
    
    func fetchUpcomingGames() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        db.collection("games")
            .whereField("creatorID", isEqualTo: uid)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                self.upcomingGames = documents.compactMap { queryDocumentSnapshot -> Game? in
                    return try? queryDocumentSnapshot.data(as: Game.self)
                }
            }
    }
        
    func checkIfLocationServicesIsEnabled() {
        // 1. Check if user enabled locations
        if CLLocationManager.locationServicesEnabled() {
            // 2. Check if our app has permission to use user's location
            locationManager = CLLocationManager() // calls locationManagerDidChangeAuthorization()
            locationManager?.delegate = self
            locationManager?.activityType = CLActivityType.fitness
            
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
            fetchNearbyLocations()
//            fetchUpcomingGames()
            break
        @unknown default:
            break
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    init(name: String = "", coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()) {
        self.name = name
        self.coordinate = coordinate
    }
}
