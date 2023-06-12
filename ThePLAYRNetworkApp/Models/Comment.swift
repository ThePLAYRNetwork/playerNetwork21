//
//  Comment.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import Foundation
import CloudKit

struct Comment: Identifiable {
    var id: String = UUID().uuidString
    var message: String = ""
    var postID: CKRecord.Reference
    var numberOfLikes = 0
    var numberOfReplies = 0

    var author: User?
    var authorID: CKRecord.ID? // metadata
    var createdAt = Date() // metadata

    var isLiked = false

    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    
    init(message: String = "", postID: CKRecord.ID = CKRecord.ID(recordName: "Comment"), author: User? = nil) {
        self.message = message
        self.postID = CKRecord.Reference(recordID: postID, action: .none)
        self.author = author
    }
    
    init?(record: CKRecord) {
        guard let message = record[Comment.RecordKey.message] as? String,
              let postID = record[Comment.RecordKey.postID] as? CKRecord.Reference,
              let numberOfLikes = record[Comment.RecordKey.numberOfLikes] as? Int,
              let numberOfReplies = record[Comment.RecordKey.numberOfReplies] as? Int,
              let authorID = record.creatorUserRecordID,
              let createdAt = record.creationDate
        else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.message = message
        self.numberOfLikes = numberOfLikes
        self.numberOfReplies = numberOfReplies
        self.postID = postID
        self.authorID = authorID
        self.createdAt = createdAt
    }
    
    func convertToRecord() async -> CKRecord {
        let record = CKRecord(recordType: "Comment", recordID: self.recordID)
        record[Comment.RecordKey.message] = message
        record[Comment.RecordKey.postID] = postID
        record[Comment.RecordKey.numberOfLikes] = numberOfLikes
        record[Comment.RecordKey.numberOfReplies] = numberOfReplies

        return record
    }

}

extension Comment {
    enum RecordKey: String {
        case message, postID, numberOfLikes, numberOfReplies
    }
    
    static let sampleComments: [Comment] = [
        Comment(message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat!")
    ]
}

extension CKRecord {
    subscript(key: Comment.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
