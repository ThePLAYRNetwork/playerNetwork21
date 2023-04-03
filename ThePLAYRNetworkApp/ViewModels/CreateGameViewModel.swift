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

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private let gameRepository: GameRepository
    private let navigationModel: NavigationModel
    var locationManager: CLLocationManager?
    var mapView = MKMapView()
    
    init(gameRepository: GameRepository, navigationModel: NavigationModel) {
        self.gameRepository = gameRepository
        self.navigationModel = navigationModel

    }
    
    func createGame() async {
        let result = await gameRepository.createGame(game: newGame)
        switch result {
        case .success(let game):
            // Game created successfully
            self.navigationModel.path.removeLast()       // remove confirmation screen
            self.navigationModel.tabSelection = .home    // show home screen
            self.navigationModel.showGameCreatedSuccessAlert = true
            self.newGame = Game() // clear inputs
            return
        case .failure(_):
            // Failed to create game
            self.navigationModel.showiCloudErrorAlert = true
            return
        }
    }
    
    
}

extension CreateGameViewModel {
    
    // MARK - Map stuff
    
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
            // 1. Clear markers
            let annotations = self.mapView.annotations
            self.mapView.removeAnnotations(annotations)
            
            // 2. Set marker to user current position
            let userCurrentCoord = locationManager.location!.coordinate
            let marker = MKPointAnnotation()
            marker.title = "Create game here?"
            marker.coordinate = userCurrentCoord
            self.mapView.addAnnotation(marker)
            
            // 3. Set camera to user's location
            self.region = MKCoordinateRegion(
                center: userCurrentCoord,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.mapView.region = self.region
        
            break
        @unknown default:
            break
        }
    }
}
