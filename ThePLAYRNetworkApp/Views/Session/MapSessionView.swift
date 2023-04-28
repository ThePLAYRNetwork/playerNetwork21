//
//  MapSessionView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/27/23.
//

import SwiftUI
import MapKit
import CoreLocation


struct MapSessionView: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    
    
    var body: some View {
        VStack {
            CreateSessionMapView()
                .ignoresSafeArea()
                .cornerRadius(7)
            
            
            
            
            Text("\(sessionViewModel.newSession.location.coordinate.latitude) \(sessionViewModel.newSession.location.coordinate.longitude)")
            
            
    }
  }
}
                 
                 struct MapSessionView_Previews: PreviewProvider {
                static var previews: some View {
                    MapSessionView()
                }
            }
                 
                 
                 @MainActor
                 struct CreateSessionMapView: UIViewRepresentable {
                @EnvironmentObject var sessionViewModel: SessionViewModel
                @EnvironmentObject var homeViewModel: HomeViewModel
                @EnvironmentObject var locationManager: LocationManager
                
                
                
                
                func makeUIView(context: Context) -> MKMapView {
                    print("Making ui: \(sessionViewModel.newSession.location)")
                    self.sessionViewModel.mapView.delegate = context.coordinator
                    self.sessionViewModel.mapView.showsUserLocation = true
                    
                    // Clear markers
                    let annotations = self.sessionViewModel.mapView.annotations
                    self.sessionViewModel.mapView.removeAnnotations(annotations)
                    
                    if sessionViewModel.newSession.location != CLLocation() {
                        print("Showing game location")
                        
                        // 2. Set marker to address coordinates
                        let marker = MKPointAnnotation()
                        marker.title = "Create game here?"
                        marker.coordinate = sessionViewModel.newSession.location.coordinate
                        self.sessionViewModel.mapView.addAnnotation(marker)
                        
                        // 3. Set camera to game's address
                        self.sessionViewModel.region = MKCoordinateRegion(
                            center: sessionViewModel.newSession.location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                        self.sessionViewModel.mapView.region = self.sessionViewModel.region
                        
                    } else if let location = locationManager.userLocation {
                        let coordinate = location.coordinate
                        //            self.createViewModel.newGame.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        // 2. Set marker to address coordinates
                        let marker = MKPointAnnotation()
                        marker.title = "Create game here?"
                        marker.coordinate = coordinate
                        self.sessionViewModel.mapView.addAnnotation(marker)
                        
                        print("Showing user location")
                        // 3. Set camera to user's location
                        self.sessionViewModel.mapView.region = MKCoordinateRegion(
                            center: location.coordinate,
                            latitudinalMeters: 1000,
                            longitudinalMeters: 1000
                        )
                    } else {
                        // Show default location?
                    }
                    return self.sessionViewModel.mapView
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
                    var parent: CreateSessionMapView
                    
                    var gRecognizer = UITapGestureRecognizer() // can use regular tap
                    
                    init(_ parent: CreateSessionMapView) {
                        self.parent = parent
                        super.init()
                        self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
                        self.gRecognizer.delegate = self
                        self.parent.sessionViewModel.mapView.addGestureRecognizer(gRecognizer)
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
                        let currentAnnotations = self.parent.sessionViewModel.mapView.annotations
                        self.parent.sessionViewModel.mapView.removeAnnotations(currentAnnotations)
                        
                        // 2. position on the screen, CGPoint
                        let location = gRecognizer.location(in: self.parent.sessionViewModel.mapView)
                        // position on the map, CLLocationCoordinate2D
                        let coordinate = self.parent.sessionViewModel.mapView.convert(location, toCoordinateFrom: self.parent.sessionViewModel.mapView)
                        
                        // 3. Set new annotations
                        let marker = MKPointAnnotation()
                        marker.title = "Create game here?"
                        marker.coordinate = coordinate
                        self.parent.sessionViewModel.mapView.addAnnotation(marker)
                        self.parent.sessionViewModel.newSession.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                        self.parent.sessionViewModel.region = MKCoordinateRegion(
                            center: coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    }
                }
            }
                 
