//
//  Post.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/12/22.
//

import Foundation
import CloudKit

struct Post: Identifiable {
    var id: String
    var message: String
    var authorID: CKRecord.Reference?
    var author: User? // maybe delete? can get author ID
    var createdAt: Date
    var likes: Int
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    init(message: String = "", createdAt: Date = Date(), likes: Int = 0) {
        self.id = UUID().uuidString
        self.message = message
        self.createdAt = createdAt
        self.likes = likes
    }
    
    // record.parent? might be usefull
    init?(record: CKRecord) {
        guard let message = record[Post.RecordKey.message] as? String,
              let authorID = record[Post.RecordKey.authorID] as? CKRecord.Reference,
              let createdAt = record.creationDate,
              let likes = record[Post.RecordKey.likes] as? Int
        else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.authorID = authorID
        self.message = message
        self.createdAt = createdAt
        self.likes = likes
    }
    
    
    func convertToRecord() async throws -> CKRecord {
        let record = CKRecord(recordType: "Post", recordID: self.recordID)
        let authorID = try await CKContainer.default().userRecordID()
        record[Post.RecordKey.message] = self.message
        // TODO: record already has "createdBy" field, might be useless
        record[Post.RecordKey.authorID] = CKRecord.Reference(recordID: authorID, action: .none)
        record[Post.RecordKey.createdAt] = Date()
        record[Post.RecordKey.likes] = 0
        return record
    }
    
    mutating func fetchAuthor(authorID: CKRecord.Reference) async {
        do {
            var container: CKContainer = CKContainer.default()
            var database: CKDatabase = container.publicCloudDatabase
            let predicate = NSPredicate(format: "\(User.RecordKey.userID.rawValue) == %@", authorID)
            let query = CKQuery(recordType: "User", predicate: predicate)
            
            let (userResults, _) = try await database.records(matching: query, resultsLimit: 1)
            
            if let userResult = userResults.first {
                let record = try userResult.1.get()
                let user = try User(record: record)
                print("Succesfully fetched author")
                self.author = user
            } else {
                print("Author not found")
            }
        } catch {
            print("Failed to get author: \(error)")
        }
    }
}

extension Post {
    struct Comments {
        var recordName: String
        var message: String
        var postID: CKRecord.Reference
        var userID: CKRecord.Reference
        var createdAt: Date
    }
    
    struct Likes {
        var recordName: String
        var postID: CKRecord.Reference
        var userID: CKRecord.Reference
    }
    
    static let samplePosts: [Post] = [
        Post(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", createdAt: Date(), likes: 15),
        Post(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat!", createdAt: Date(), likes: 10)
    ]
    
    enum RecordKey: String {
        case message, authorID, createdAt, likes
    }
}

extension CKRecord {
    subscript(key: Post.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
