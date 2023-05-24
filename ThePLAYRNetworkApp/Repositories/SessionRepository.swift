//
//  SessionRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 4/3/23.
//

import Foundation
import CloudKit



protocol SessionApiService {
    func createSession(session: Session) async -> Result<Session, Error>
    
    //  func getSession() async throws -> Result<Session, Error>
}



class SessionRepository: ObservableObject, SessionApiService {
    @Published var sessions: [Session] = []

    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
//    init() {
//        fetchSession()
//        
//    }
//    
    
    func createSession(session: Session) async -> Result<Session, Error> {
        do {
            let record = try await session.createSessionRecord()
            let sessionRecord = try await database.save(record)
            print("Session saves successfully:\n\(sessionRecord)")
            return .success (session)
        } catch {
            print("Failed to save session: \(error)")
            return.failure(error)
        }
    }
    
    
    
    func fetchNearByGames(location: CLLocation) async -> Result<[Session], Error> {
        let radius = 10000 // meters
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radius)
        let query = CKQuery(recordType: "Sessions", predicate: predicate)
        
        do {
            var (sessionResults, _) = try await database.records(matching: query, resultsLimit: 10)
            
            let sessions: [Session] = sessionResults
                .compactMap { _, result in
                    guard let record = try? result.get() else { return nil }
                    return try? Session(record: record)
                }
            print("Sucessfully got nearby games")
            return .success(sessions)
            
        } catch {
            print("Failed to get nearby games: \(error)")
            return .failure(error)
        }
    }
    
//    func fetchSession(location: CLLocation) async -> Result<[Session], Error> {
//
//        let predicate = NSPredicate(value: true)
//        let query = CKQuery(recordType: "Session", predicate: predicate)
//
//
//        do {
//            var (sessionResults, _) = try await database.records(matching: query, resultsLimit: 10)
//
//            let sessions: [Session] = sessionResults
//                .compactMap { _, result in
//                    guard let record = try? result.get() else { return nil }
//                    return try? Session(record: record)
//                }
//            print("Sucessfully got sessions")
//            return .success(sessions)
//
//        } catch {
//            print("Failed to get sessions: \(error)")
//            return .failure(error)
//        }
//    }
        
        
        //        let queryOperation = CKQueryOperation(query: query)
        //
        //        var returnedSessions: [Session] = []
        //
        //        queryOperation.recordMatchedBlock { (returnedRecordID, returnedResult) in
        //            switch returnedResult {
        //            case .success(let record):
        //                guard let session = record["Session"] as? String else { return }
        //                returnedSessions.append(session)
        //            case .failure(let error):
        //               print("Error recordMatchedBlock: \(error)")
        //            }
        //        }
        //
        //
        //        queryOperation.queryResultBlock = { [weak self] returnedResult  in
        //            print("RETURNED RESULT: \(returnedResult)")
        //            self?.sessions = returnedSessions
        //        }
        //
        //        addOperations(operation: queryOperation)
        //   }
        
        
        
        func addOperations(operation: CKDatabaseOperation) {
            CKContainer.default().publicCloudDatabase.add(operation)
            
        }
        
        
//    func getSession() {
//
//        let query = CKQuery(recordType: "Session",
//                            predicate: NSPredicate(value: true))
//        database.perform(query, inZoneWith: nil) { [weak self] records, error in
//            guard let records = records, error == nil else {
//                return
//            }
//            self?.sessions = records.compactMap({ $0.value(forKey: "Session") as! Session })
//
//        }
//    }
//
        
        
        
        func getSession() async throws -> Result<Session, Error> {

            do {
//                let sessionID = try await container.userRecordID()
                // fetch our custom user object using user's id
//                let recordToMatch = CKRecord.Reference(recordID: sessionID, action: .none)
                let predicate = NSPredicate(value: true)
                //NSPredicate(format: "\(Session.RecordKey.id.rawValue)")
                let query = CKQuery(recordType: "Session", predicate: predicate)

                let (results, _) = try await database.records(matching: query, resultsLimit: 1)
                print(results)
                if let result = results.first {
                    let record = try result.1.get()
                    let session = try Session()
                    print("Succesfully fetched session from CloudKit")
                    return .success(session)
                } else {
                    print("Failed to get session from CloudKit. User has not created account yet.")
                    return .failure(CloudKitError.userRecordNotFound)
                }
            } catch {
                print("Failed to get user from cloudkit")
                return .failure(error)
            }
        }
        
        

    
}


extension CKRecord {
    subscript(key: Session.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
