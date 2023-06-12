//
//  Reply.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/4/23.
//

import Foundation
import CloudKit

struct Reply: Identifiable {
    var id: String = UUID().uuidString
    var message: String = ""
    var commentID: CKRecord.Reference
    var numberOfLikes = 0
    
    var author: User?
    var authorID: CKRecord.ID? // metadata
    var createdAt = Date() // metadata

    var isLiked = false

    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    init(message: String = "", commentID: CKRecord.ID = CKRecord.ID(recordName: "Reply"), author: User? = nil) {
        self.message = message
        self.commentID = CKRecord.Reference(recordID: commentID, action: .none)
        self.author = author
    }
    
    init?(record: CKRecord) {
        guard let message = record[Reply.RecordKey.message] as? String,
              let commentID = record[Reply.RecordKey.commentID] as? CKRecord.Reference,
              let numberOfLikes = record[Reply.RecordKey.numberOfLikes] as? Int,
              let authorID = record.creatorUserRecordID,
              let createdAt = record.creationDate
        else {
            return nil
        }
        
        self.id = record.recordID.recordName
        self.message = message
        self.numberOfLikes = numberOfLikes
        self.commentID = commentID
        self.authorID = authorID
        self.createdAt = createdAt
    }
    
    func convertToRecord() async -> CKRecord {
        let record = CKRecord(recordType: "Reply", recordID: self.recordID)
        record[Reply.RecordKey.message] = self.message
        record[Reply.RecordKey.commentID] = commentID
        record[Reply.RecordKey.numberOfLikes] = numberOfLikes
        return record
    }
}

extension Reply {
    enum RecordKey: String {
        case message, commentID, numberOfLikes
    }
}

extension CKRecord {
    subscript(key: Reply.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
