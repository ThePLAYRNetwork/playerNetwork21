//
//  CreateViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/1/22.
//

import Foundation
import MapKit

@MainActor
class CreateGameViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var newGame = Game()
//    @Published var newGame = Game.sampleGames[0]
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published var locationSearchService = LocationSearchService()

    
    private let gameRepository: GameRepository
    private let navigationModel: NavigationModel
//    var locationManager: CLLocationManager?
    var mapView = MKMapView()
    
    init(gameRepository: GameRepository, navigationModel: NavigationModel) {
        self.gameRepository = gameRepository
        self.navigationModel = navigationModel

    }
    
    func createGame() async {
        let result = await gameRepository.createGame(game: newGame)
        switch result {
        case .success(let game):
            gameRepository.games.append(game)
            // Game created successfully
            self.navigationModel.gamePath.removeLast()       // remove confirmation screen
            self.navigationModel.tabSelection = .home    // show home screen
            self.navigationModel.showGameCreatedSuccessAlert = true
            // clear inputs
            self.newGame = Game()
            self.locationSearchService.searchQuery = ""
            return
        case .failure(_):
            // Failed to create game
            self.navigationModel.showiCloudErrorAlert = true
            return
        }
    }
    
    func convertAddressToCoordinates() async {
        do {
            guard let completion = locationSearchService.selectedCompletion else { return }
            let geoCoder = CLGeocoder()
            
            if let location = try await geoCoder.geocodeAddressString(completion.subtitle).first?.location {
                print("Successfully got coordinates")
                newGame.location = location
                newGame.place = completion.title
                newGame.address = completion.subtitle
            } else if let userLocation = LocationManager.shared.userLocation {
                print("Failed to convert address to coordintes")
                newGame.location = userLocation
            }
        } catch {
            print("Erroring converting address into coordinates: \(error)")
            if let userLocation = LocationManager.shared.userLocation {
                newGame.location = userLocation
            }
        }
    }
    
}

//extension CreateGameViewModel {
//
//    // MARK - Map stuff
//
//    func checkIfLocationServicesIsEnabled() {
//        // 1. Check if user enabled locations
//        if CLLocationManager.locationServicesEnabled() {
//            // 2. Check if our app has permission to use user's location
//            locationManager = CLLocationManager() // calls locationManagerDidChangeAuthorization()
//            locationManager?.delegate = self
//            locationManager?.activityType = CLActivityType.fitness
//        } else {
//            print("Show an alert letting them know this is off and go turn it on")
//        }
//    }
//
//    // this func gets call when we create CLLocationManager() and if the user changes permissions
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
//    }
//
//    private func checkLocationAuthorization() {
//        guard let locationManager = locationManager else {
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
//            // 1. Clear markers
//            let annotations = self.mapView.annotations
//            self.mapView.removeAnnotations(annotations)
//
//            // 2. Set marker to address coordinates
////            let userCurrentCoord = locationManager.location!.coordinate
//            let marker = MKPointAnnotation()
//            marker.title = "Create game here?"
//            marker.coordinate = newGame.location.coordinate
//            self.mapView.addAnnotation(marker)
//
//            // 3. Set camera to user's location
//            self.region = MKCoordinateRegion(
//                center: newGame.location.coordinate,
//                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//            self.mapView.region = self.region
//
//            break
//        @unknown default:
//            break
//        }
//    }
//}
