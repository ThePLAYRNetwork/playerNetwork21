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
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    func fetchSession() async -> Result<[Session], Error> {
        do {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "Session", predicate: predicate)
            
            do {
                var (sessionResults, _) = try await database.records(matching: query)
                
                var sessions: [Session] = try sessionResults
                    .compactMap { _, result in
                        let record = try result.get()
                        return try Session(record: record)
                    }
                
                return .success(sessions)
            } catch {
                return .failure(error)
            }
        }
    }
    
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
    
    
    func addOperations(operation: CKDatabaseOperation) {
        CKContainer.default().publicCloudDatabase.add(operation)
        
    }
    
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
