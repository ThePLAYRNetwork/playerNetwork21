//
//  SessionViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/3/23.
//

import Foundation
import MapKit


@MainActor
class SessionViewModel: NSObject,ObservableObject, CLLocationManagerDelegate {
    @Published var newSession = Session()
    
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @Published var locationSearchService = LocationSearchService()
    
    private let sessionRepository: SessionRepository
    private let navigationModel: NavigationModel
    
    var mapView = MKMapView()
    
    init(sessionRepository: SessionRepository, navigationModel: NavigationModel) {

        self.sessionRepository = sessionRepository
        self.navigationModel = navigationModel
    }
    
    func createSession() async {
        let result = await sessionRepository.createSession(session: newSession)
        switch result {
        case .success(let session):
           self.navigationModel.path.removeLast()
            self.navigationModel.tabSelection = .home    // show home screen
            self.navigationModel.showSessionCreateSuccessAlert = true
            
            
          print("Created sessions successfully")
            self.newSession = Session() // clear inputs
            return
        case .failure(_):
            self.navigationModel.showiCloudErrorAlert = true
         print("failed to create a session")
            return
        }
    }
    
    
    
    func convertAddressToCoordinates() async {
        do {
            guard let completion = locationSearchService.selectedCompletion else { return }
            let geoCoder = CLGeocoder()
            
            if let location = try await geoCoder.geocodeAddressString(completion.subtitle).first?.location {
                print("Successfully got coordinates")
                newSession.location = location
                newSession.place = completion.title
               // newSession.address = completion.subtitle
            } else if let userLocation = LocationManager.shared.userLocation {
                print("Failed to convert address to coordintes")
                newSession.location = userLocation
            }
        } catch {
            print("Erroring converting address into coordinates: \(error)")
            if let userLocation = LocationManager.shared.userLocation {
                newSession.location = userLocation
            }
        }
    }
    
}


