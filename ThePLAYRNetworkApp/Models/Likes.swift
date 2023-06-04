//
//  isLiked.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/24/23.
//

import Foundation
import CloudKit

struct Likes: Identifiable {
    var id: String
    var postID: CKRecord.Reference
    
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    init(postID: CKRecord.ID) {
        self.id = UUID().uuidString
        self.postID = CKRecord.Reference(recordID: postID, action: .none)
    }
    
    func convertToRecord() -> CKRecord {
        let record = CKRecord(recordType: "Likes", recordID: recordID)
        record[Likes.RecordKey.postID] = postID
        return record
    }
    
}

extension Likes {
    enum RecordKey: String {
        case postID
    }
}


extension CKRecord {
    subscript(key: Likes.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
