//
//  Post.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/12/22.
//

import Foundation
import CloudKit

struct Post: Identifiable {
    var id: String = UUID().uuidString
    var message: String = ""
    var numberOfLikes: Int = 0
    var numberOfComments = 0
    var authorID: CKRecord.ID? // metadata
    var author: User?
    var createdAt = Date() // metadata
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    var isLiked = false
    
    init(message: String = "") {
        self.message = message
    }
    
    // record.parent? might be usefull
    init?(record: CKRecord) {
        guard let message = record[Post.RecordKey.message] as? String,
              let numberOfLikes = record[Post.RecordKey.numberOfLikes] as? Int,
              let numberOfComments = record[Post.RecordKey.numberOfComments] as? Int,
              let creatorID = record.creatorUserRecordID,
              let createdAt = record.creationDate
        else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.message = message
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
        self.authorID = creatorID
        self.createdAt = createdAt
    }
    
    
    func convertToRecord() async -> CKRecord {
        let record = CKRecord(recordType: "Post", recordID: self.recordID)
        record[Post.RecordKey.message] = self.message
        record[Post.RecordKey.numberOfLikes] = numberOfLikes
        record[Post.RecordKey.numberOfComments] = numberOfComments
        return record
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
        Post(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
        Post(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat!")
    ]
    
    enum RecordKey: String {
        case message, numberOfLikes, numberOfComments
    }
}

extension CKRecord {
    subscript(key: Post.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
