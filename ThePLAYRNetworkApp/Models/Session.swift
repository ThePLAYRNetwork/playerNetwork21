//
//  Session.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/18/22.
//

import Foundation
import CloudKit

struct Session {
    var recordName: String
    var userID: CKRecord.Reference
    var title: String
    var location: String
    var price: Int
    var startDate: Date
    var endDate: Date
    var details: String
    var coverImage: CKAsset
    // var availability: [Date] TODO: change later.
    
}


extension Session {
    static let dummyReference: CKRecord.Reference = CKRecord.Reference(record: CKRecord(recordType: "Dummy"), action: .none)
    static let sampleSessions: [Session] = [
        Session(recordName: "", userID: dummyReference, title: "", location: "", price: 0, startDate: Date(), endDate: Date(), details: "", coverImage: CKAsset(fileURL: URL(string: "")!))
    ]
}
