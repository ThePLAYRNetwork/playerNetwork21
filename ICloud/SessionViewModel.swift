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
    
    
    private var db = CKContainer.default().publicCloudDatabase
    @Published private var sessionDictionary: [CKRecord.ID: Session] = [:]
    
//    var sessions: [Session] {
//        sessionDictionary.values.compactMap { $0 }
//    }
    @Published var sessions: [Session] = []
 

    
        // func fetchSession() async throws {
//        func fetchNearByGames(location: CLLocation) async -> Result<[Session], Error> {
//        let radius = 10000 // meters
//        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radius)
//        let query = CKQuery(recordType: "Sessions", predicate: predicate)
//
//        do {
//            var (sessionResults, _) = try await database.records(matching: query, resultsLimit: 10)
//
//            let sessions: [Session] = sessionResults
//                .compactMap { _, result in
//                    guard let record = try? result.get() else { return nil }
//                    return try? Session(record: record)
//                }
//            print("Sucessfully got nearby games")
//            return .success(sessions)
//
//        } catch {
//            print("Failed to get nearby games: \(error)")
//            return .failure(error)
//        }
        
        
        
//        let query = CKQuery(recordType: "Sessions", predicate: NSPredicate(value: true))
//       query.sortDescriptors = [NSSortDescriptor(key: "startDate", ascending: false)]
//        let result = try await db.records(matching: query)
//        let records = result.matchResults.compactMap { try? $0.1.get() }
//
//        sessions = records.compactMap {
//            try? Session(record: $0)
//        }
//
//        records.forEach { record in
//            sessionDictionary[record.recordID] = try? Session(record: record)
//        }
        
  //  }
    
    
    
    
    func addSession(session: Session) async throws {
           let record = try await db.save(session.record)
           guard let session = try? Session(record: record) else { return }
   
           sessionDictionary[session.recordID] = session
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






//@MainActor
//class SessionViewModel: NSObject,ObservableObject, CLLocationManagerDelegate {
//    @Published var newSession = Session()
//    @Published private var sessionDictionary: [CKRecord.ID: Session] = [:]

//
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//
//    @Published var locationSearchService = LocationSearchService()
//
//
//
//    private let sessionRepository: SessionRepository
//    private let navigationModel: NavigationModel
//
//    var mapView = MKMapView()
//
//    init(sessionRepository: SessionRepository, navigationModel: NavigationModel) {
//
//        self.sessionRepository = sessionRepository
//        self.navigationModel = navigationModel
//    }
//
//
//
//
//    func createSession() async {
//        let result = await sessionRepository.createSession(session: newSession)
//        switch result {
//        case .success(let session):
//            self.navigationModel.homePath.removeLast(2)
//            self.navigationModel.tabSelection = .home    // show home screen
//            self.navigationModel.showSessionCreateSuccessAlert = true
//
//
//          print("Created sessions successfully")
//
//
//            self.newSession = Session() // clear inputs
//            return
//        case .failure(_):
//            self.navigationModel.showiCloudErrorAlert = true
//         print("failed to create a session")
//            return
//        }
//    }
//
//    func fetchSession() async throws {
//
//        let query = CKQuery(recordType: SessionRecordKeys.type.rawValue , predicate: NSPredicate(value: true))
//
//        query.sortDescriptors = [NSSortDescriptor(key: "Session", ascending: false )]
//
//        let result = try await CKContainer.default().publicCloudDatabase.records(matching: query)
//        let records = result.matchResults.compactMap { try? $0.1.get() }
//
//        records.forEach { record in
//            sessionDictionary[record.recordID] = try? Session(record: record)
//
//        }
//
//
//    }
//

//}
//
//
