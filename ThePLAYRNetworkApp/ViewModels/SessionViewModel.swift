//
//  SessionViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/3/23.
//

import Foundation
import MapKit
import CloudKit

@MainActor
class SessionViewModel: ObservableObject {
    @Published var newSession = Session()
    @Published private var sessionDictionary: [CKRecord.ID: Session] = [:]
    @Published var sessions: [Session] = []


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
        
        Task {
            await fetchSession()
        }
    }
    
    func createSession() async {
        let result = await sessionRepository.createSession(session: newSession)
        switch result {
        case .success(let session):
            self.navigationModel.homePath.removeLast(2)
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

    func fetchSession() async {
        let result = await sessionRepository.fetchSession()
        switch result {
        case .success(let sessions):
            self.sessions = sessions
            print("Sucessfully got sessions: \(sessions.count)")
        case .failure(let error):
            print("Error fetching session: \(error)")
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
                newSession.address = completion.subtitle
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


