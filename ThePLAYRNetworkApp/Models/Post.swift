//
//  Post.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/12/22.
//

import Foundation
import CloudKit

struct Post {
    var recordName: String
    var message: String
    var userID: CKRecord.Reference
    var createdAt: Date
    var likes: Int
    var isLiked: Bool
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
        Post(recordName: "", message: "", userID: CKRecord.Reference(record: CKRecord(recordType: "Dummy"), action: .none), createdAt: Date(), likes: 0, isLiked: true)
    ]
}
