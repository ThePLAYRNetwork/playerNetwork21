//
//  SessionRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 3/31/23.
//

import Foundation
import CloudKit



protocol SessionApiService {
    func createSession(session: Session) async -> Result<Void, Error>
    
  //  func getSession() async throws -> Result<Session, Error>
}



class SessionRepository: SessionApiService {
 
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    
    func createSession(session: Session) async -> Result<Void, Error> {
        do {
            let record = try await session.createSessionRecord()
            let sessionRecord = try await database.save(record)
            print("Session saves successfully:\n\(sessionRecord)")
            return .success (())
        } catch {
            print("Failed to save session: \(error)")
            return.failure(error)
        }
    }
    
    
//    func getSession() async throws -> Result<Session, Error> {
//        do {
//            let sessionID = try await container.userRecordID()
//            // fetch our custom user object using user's id
//            let recordToMatch = CKRecord.Reference(recordID: sessionID, action: .none)
//        //    let predicate = NSPredicate(format: "\(Session.RecordKey.userID.rawValue) == %@", recordToMatch)
//            let query = CKQuery(recordType: "Session", predicate: predicate)
//
//            let (results, _) = try await database.records(matching: query, resultsLimit: 1)
//
//            if let result = results.first {
//                let record = try result.1.get()
//                let session = try Session(record: record)
//                print("Succesfully fetched session from CloudKit")
//                return .success(session)
//            } else {
//                print("Failed to get session from CloudKit. User has not created account yet.")
//                return .failure(CloudKitError.userRecordNotFound)
//            }
//        } catch {
//            print("Failed to get user from cloudkit")
//            return .failure(error)
//        }
//    }
    

    
    
}
