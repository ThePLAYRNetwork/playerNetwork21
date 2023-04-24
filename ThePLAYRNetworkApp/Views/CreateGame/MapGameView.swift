//
//  MapForCreateGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/28/22.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapGameView: View {
    @EnvironmentObject var createGameViewModel: CreateGameViewModel
    @EnvironmentObject var locationManager: LocationManager

    var body: some View {
        VStack {
            CreateGameMapView()
                .ignoresSafeArea()
                .cornerRadius(7)
            // for coordinate testing
            Text("\(createGameViewModel.newGame.location.coordinate.latitude) \(createGameViewModel.newGame.location.coordinate.longitude)")
            
        }
//        .onAppear {
//            viewModel.checkIfLocationServicesIsEnabled()
//        }
        
    }
}

struct MapGameView_Previews: PreviewProvider {
    static var previews: some View {
        MapGameView()
            .environmentObject(CreateGameViewModel(gameRepository: GameRepository(), navigationModel: NavigationModel()))
    }
}

@MainActor
struct CreateGameMapView: UIViewRepresentable {
    @EnvironmentObject var createViewModel: CreateGameViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var locationManager: LocationManager

    // Creates UI and inital state
    func makeUIView(context: Context) -> MKMapView {
        print("Making ui: \(createViewModel.newGame.location)")
        self.createViewModel.mapView.delegate = context.coordinator
        self.createViewModel.mapView.showsUserLocation = true

        // Clear markers
        let annotations = self.createViewModel.mapView.annotations
        self.createViewModel.mapView.removeAnnotations(annotations)

        if createViewModel.newGame.location != CLLocation() {
            print("Showing game location")
            
            // 2. Set marker to address coordinates
            let marker = MKPointAnnotation()
            marker.title = "Create game here?"
            marker.coordinate = createViewModel.newGame.location.coordinate
            self.createViewModel.mapView.addAnnotation(marker)
            
            // 3. Set camera to game's address
            self.createViewModel.region = MKCoordinateRegion(
                center: createViewModel.newGame.location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            self.createViewModel.mapView.region = self.createViewModel.region

        } else if let location = locationManager.userLocation {
            let coordinate = location.coordinate
//            self.createViewModel.newGame.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            // 2. Set marker to address coordinates
            let marker = MKPointAnnotation()
            marker.title = "Create game here?"
            marker.coordinate = coordinate
            self.createViewModel.mapView.addAnnotation(marker)

            print("Showing user location")
            // 3. Set camera to user's location
            self.createViewModel.mapView.region = MKCoordinateRegion(
                center: location.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
        } else {
            // Show default location?
        }
        return self.createViewModel.mapView
    }
    
    // Calls UI is created or updated (e.g. user adds new marker)
    func updateUIView(_ view: MKMapView, context: Context) {
//        print("Updating")
    }
    func makeCoordinator() -> Coordinator {
//        return Coordinator(self, self.createViewModel)
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
//        private var viewModel: CreateGameViewModel
        var parent: CreateGameMapView
        
        var gRecognizer = UITapGestureRecognizer() // can use regular tap
        
        init(_ parent: CreateGameMapView) {
            self.parent = parent
            super.init()
            self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.gRecognizer.delegate = self
            self.parent.createViewModel.mapView.addGestureRecognizer(gRecognizer)
        }
//        init(_ parent: CreateGameMapView, _ viewModel: CreateGameViewModel) {
//            self.parent = parent
//            self.viewModel = viewModel
//            super.init()
//            self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
//            self.gRecognizer.delegate = self
//            self.parent.createViewModel.mapView.addGestureRecognizer(gRecognizer)
//        }
        
        @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
            // 1. Clear previous annotations
            let currentAnnotations = self.parent.createViewModel.mapView.annotations
            self.parent.createViewModel.mapView.removeAnnotations(currentAnnotations)
            
            // 2. position on the screen, CGPoint
            let location = gRecognizer.location(in: self.parent.createViewModel.mapView)
            // position on the map, CLLocationCoordinate2D
            let coordinate = self.parent.createViewModel.mapView.convert(location, toCoordinateFrom: self.parent.createViewModel.mapView)
            
            // 3. Set new annotations
            let marker = MKPointAnnotation()
            marker.title = "Create game here?"
            marker.coordinate = coordinate
            self.parent.createViewModel.mapView.addAnnotation(marker)
            self.parent.createViewModel.newGame.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            self.parent.createViewModel.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}
