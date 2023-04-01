//
//  MapForCreateGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/28/22.
//

import SwiftUI
import MapKit
import CoreLocation
//import FirebaseAuth
//import FirebaseFirestore
//import GeoFire

struct MapGameView: View {
    @EnvironmentObject var viewModel: CreateGameViewModel
    
    var body: some View {
        VStack {
            CreateGameMapView()
                .ignoresSafeArea()
                .cornerRadius(7)
            // for coordinate testing
//            Text("\(viewModel.region.center.latitude), \(viewModel.region.center.longitude)")
//            Text("\(GFUtils.geoHash(forLocation: CLLocationCoordinate2D(latitude: viewModel.region.center.latitude, longitude: viewModel.region.center.longitude)))")
        }
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
        
    }
}

struct MapGameView_Previews: PreviewProvider {
    static var previews: some View {
        MapGameView()
            .environmentObject(CreateGameViewModel())
    }
}

struct CreateGameMapView: UIViewRepresentable {
    @EnvironmentObject var viewModel: CreateGameViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        self.viewModel.mapView.delegate = context.coordinator
        self.viewModel.mapView.showsUserLocation = true
        return self.viewModel.mapView
    }
    
    // Calls when show or ui updated?
    func updateUIView(_ view: MKMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, self.viewModel)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate, UIGestureRecognizerDelegate {
        private var viewModel: CreateGameViewModel
        var parent: CreateGameMapView
        
        var gRecognizer = UITapGestureRecognizer() // can use regular tap
        
        init(_ parent: CreateGameMapView, _ viewModel: CreateGameViewModel) {
            self.parent = parent
            self.viewModel = viewModel
            super.init()
            self.gRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
            self.gRecognizer.delegate = self
            self.parent.viewModel.mapView.addGestureRecognizer(gRecognizer)
        }
        
        @objc func tapHandler(_ gesture: UITapGestureRecognizer) {
            // 1. Clear previous annotations
            let currentAnnotations = self.parent.viewModel.mapView.annotations
            self.parent.viewModel.mapView.removeAnnotations(currentAnnotations)
            
            // 2. position on the screen, CGPoint
            let location = gRecognizer.location(in: self.parent.viewModel.mapView)
            // position on the map, CLLocationCoordinate2D
            let coordinate = self.parent.viewModel.mapView.convert(location, toCoordinateFrom: self.parent.viewModel.mapView)

            // 3. Set new annotations
            let marker = MKPointAnnotation()
            marker.title = "Create game here?"
            marker.coordinate = coordinate
            self.parent.viewModel.mapView.addAnnotation(marker)
            self.parent.viewModel.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }
}
