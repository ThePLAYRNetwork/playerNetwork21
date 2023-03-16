//
//  Message.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/21/22.
//

import Foundation
import CloudKit

struct Message {
    var recordName: String
    var conversationID: CKRecord.Reference
    var senderID: CKRecord.Reference
    var receiverID: CKRecord.Reference
    var createdAt: Date
}

extension Message {
    struct Conversation {
        var recordName: String
        var userID: CKRecord.Reference
        var otherUserID: CKRecord.Reference
    }
}
