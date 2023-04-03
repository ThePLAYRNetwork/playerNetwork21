//
//  UserRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/13/23.
//

import Foundation
import CloudKit


protocol UserApiService {
    func createUser(user: User) async -> Result<User, Error>
    
    func getUser() async -> Result<User, Error>
    
    func getPlayerStyles() async -> Result<[PlayerStyle], Error>
}

class UserRepository: UserApiService {
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase

    func createUser(user: User) async -> Result<User, Error> {
        do {
            let record = try await user.createUserRecord()
            let userRecord = try await database.save(record)
            print("User saved successfully:\n\(userRecord)")
            return .success(user)
        } catch {
            print("Failed to create user: \(error)")
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
                print("Succesfully fetched user")
                return .success(user)
            } else {
                print("User not found, user has not set up profile.")
                return .failure(CloudKitError.userRecordNotFound)
            }
        } catch {
            print("Failed to get user from cloudkit: \(error)")
            return .failure(error)
        }
    }
    
    func getPlayerStyles() async -> Result<[PlayerStyle], Error> {
        do {
            let predicate = NSPredicate(value: true) // get all (which is really just max of 100)
            let query = CKQuery(recordType: "PlayerStyle", predicate: predicate)
            let (results, _) = try await database.records(matching: query)
            let records: [CKRecord] = try results.map { try $0.1.get() }
            let playerStyles: [PlayerStyle] = try records.map { try PlayerStyle(record: $0) }
            print("Succesfully fetched player styles")
            return .success(playerStyles)
        } catch {
            print("Failed to get player styles: \(error)")
            return .failure(error)
        }
    }
}

extension CKRecord {
    subscript(key: User.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
