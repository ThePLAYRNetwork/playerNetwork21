//
//  Session.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/18/22.
//

import Foundation
import CloudKit

struct Session: Identifiable {
    var id: String
    var title: String
    var location: String
    var price: Int
    var startDate: Date
    var endDate: Date
    var duration: String
    var details: String
    var coverImage: CKAsset?
    // var availability: [Date] TODO: change later.
    
    
    
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    
    
    init(id: String = "", title: String = "", location: String = "", price: Int = 0, startDate: Date, endDate: Date, duration: String = "", details: String = "", coverImage: CKAsset? = nil) {
        
        self.id = UUID().uuidString
        self.title = title
        self.location = location
        self.price = price
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.details = details
        self.coverImage = coverImage
    }
    
    
//    init(record: CKRecord) throws {
//
//        guard let id = record[.id] as? String else {
//             throw RecordError.missingKey(.id)
//         }
//        
//        guard let title = record[.title] as? String else {
//            throw RecordError.missingKey(.title)
//        }
//        
//        guard let location = record[.location] as? String else {
//            throw RecordError.missingKey(.location)
//        }
//        
//        
//        guard let price = record[.price] as? Int else {
//            throw RecordError.missingKey(.price)
//        }
//        
//        
//        guard let startDate = record[.startDate] as? Date else {
//            throw RecordError.missingKey(.startDate)
//        }
//        
//        guard let endDate = record[.endDate] as? Date else {
//            throw RecordError.missingKey(.endDate)
//        }
//        
//        guard let details = record[.details] as? String else {
//            throw RecordError.missingKey(.details)
//        }
//        
//        if let coverImage = record[.coverImage] as? CKAsset {
//            self.coverImage = coverImage
//        }
//        
//        
//        self.id = record.recordID.recordName
//        self.title = title
//        self.location = location
//        self.price = price
//        self.startDate = startDate
//        self.endDate = endDate
//        self.details = details
//      //  self.coverImage = coverImage
//        
//        
//    }
//    
    
    
    //Convert Session object to Record
    
    func createSessionRecord() async throws -> CKRecord {
        let sessionID = try await CKContainer.default().userRecordID()
        let record = CKRecord(recordType: "Session", recordID: self.recordID)
        
        record[.title] = self.title
        record[.location] = self.location
        record[.price] = self.price
        record[.startDate] = self.startDate
        record[.endDate] = self.endDate
        record[.details] = self.details
        record[.duration] = self.duration
        
        if let coverImage = self.coverImage?.fileURL {
            record[.coverImage] = CKAsset(fileURL: coverImage)
        }
        
        return record
    }
    
    
}


extension Session {
    struct RecordError: LocalizedError {
        var localizedDescription: String
        
        static func missingKey(_ key: RecordKey) -> RecordError {
            RecordError(localizedDescription: "Missing required key \(key.rawValue)")
        }
    }
    
    
    
    enum RecordKey: String {
        case id, title, location,price, startDate, endDate,duration, details, coverImage
    }
    
    
    
    
    
    static let dummyReference: CKRecord.Reference = CKRecord.Reference(record: CKRecord(recordType: "Dummy"), action: .none)
    
    
    static let sampleSessions: [Session] = [
        Session(id: "", title: "", location: "", price: 0, startDate: Date(), endDate: Date(),duration: "", details: ""
               // coverImage: CKAsset(fileURL: URL(string: "")!)
               )
    ]
}



extension CKRecord {
    subscript(key: Session.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
