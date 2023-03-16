//
//  UserRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/13/23.
//

import Foundation
import CloudKit

class UserRepository: UserApiService {
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase

    func createUser(user: User) async -> Result<Void, Error> {
        do {
            let record = try await user.createUserRecord()
            let userRecord = try await database.save(record)
            print("User saved successfully:\n\(userRecord)")
            return .success(())
        } catch {
            print("Failed to save user: \(error)")
            return .failure(error)
        }
    }
    
    func getUser() async -> Result<User, Error> {
        do {
            let userID = try await container.userRecordID()
            // fetch our custom user object using user's id
            let recordToMatch = CKRecord.Reference(recordID: userID, action: .none)
            let predicate = NSPredicate(format: "\(User.RecordKey.userID.rawValue) == %@", recordToMatch)
            let query = CKQuery(recordType: "User", predicate: predicate)
            
            let (results, _) = try await database.records(matching: query, resultsLimit: 1)
            
            if let result = results.first {
                let record = try result.1.get()
                let user = try User(record: record)
                print("Succesfully fetched user from CloudKit")
                return .success(user)
            } else {
                print("Failed to get user from CloudKit. User has not created account yet.")
                return .failure(CloudKitError.userRecordNotFound)
            }
        } catch {
            print("Failed to get user from cloudkit")
            return .failure(error)
        }
    }
}
