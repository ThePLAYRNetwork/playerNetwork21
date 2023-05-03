//
//  Session.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/18/22.
//

import Foundation
import CloudKit

struct Session: Hashable, Identifiable {
    var id: String
    var title: String
    var place: String
    var address: String
    var location: CLLocation
    var price: String
    var startDate: Date //date the session available, that what the user pick from the calendar
   var endDate: Date
    var duration: String
    var details: String
    var coverImage: CKAsset?
    // var availability: [Date] TODO: change later.
    
    
    
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    
    
    init(id: String = "", title: String = "", place: String = "", address: String = "", location:  CLLocation = CLLocation(), price: String = "", startDate: Date = Date(), endDate: Date = Date(), duration: String = "", details: String = "", coverImage: CKAsset? = nil) {
        
        self.id = UUID().uuidString
        self.title = title
        self.place = place
        self.address = address
        self.location = location
        self.price = price
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.details = details
        self.coverImage = coverImage
    }
    
    
    init(record: CKRecord) throws {

        guard let id = record[.id] as? String else {
             throw RecordError.missingKey(.id)
         }

        guard let title = record[Session.RecordKey.title] as? String else {
            throw RecordError.missingKey(.title)
        }

        guard let place = record[Session.RecordKey.place] as? String else {
            throw RecordError.missingKey(.place)
        }
        
        guard let address = record[Session.RecordKey.address] as? String else {
            throw RecordError.missingKey(.address)
        }
        
        
        guard let location = record[Session.RecordKey.location] as? CLLocation else {
            throw RecordError.missingKey(.location)
        }


        guard let price = record[Session.RecordKey.price] as? String else {
            throw RecordError.missingKey(.price)
        }


        guard let startDate = record[Session.RecordKey.startDate] as? Date else {
            throw RecordError.missingKey(.startDate)
        }

        guard let endDate = record[Session.RecordKey.endDate] as? Date else {
            throw RecordError.missingKey(.endDate)
        }

        guard let duration = record[Session.RecordKey.duration] as? String else {
            throw RecordError.missingKey(.duration)
        }
        
        guard let details = record[Session.RecordKey.details] as? String else {
            throw RecordError.missingKey(.details)
        }

        if let coverImage = record[Session.RecordKey.coverImage] as? CKAsset {
            self.coverImage = coverImage
        }


        self.id = record.recordID.recordName
        self.title = title
        self.place = place
        self.address = address
        self.location = location
        self.price = price
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.details = details


    }

    
    
    //Convert Session object to Record
    
    func createSessionRecord() async throws -> CKRecord {
        let record = CKRecord(recordType: "Session", recordID: self.recordID)
        
        record[Session.RecordKey.title] = self.title
        record[Session.RecordKey.place] = self.place
        record[Session.RecordKey.address] = self.address
        record[Session.RecordKey.location] = self.location
        record[Session.RecordKey.price] = self.price
        record[Session.RecordKey.startDate] = self.startDate
        record[Session.RecordKey.endDate] = self.endDate
        record[Session.RecordKey.details] = self.details
        record[Session.RecordKey.duration] = self.duration
        
        if let coverImage = self.coverImage?.fileURL {
            record[Session.RecordKey.coverImage] = CKAsset(fileURL: coverImage)
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
        case id, title, place, address, location,price, startDate, endDate,duration, details, coverImage
    }
    
    
    
    
    
    static let dummyReference: CKRecord.Reference = CKRecord.Reference(record: CKRecord(recordType: "Dummy"), action: .none)
    
    
    static let sampleSessions: [Session] = [
        Session(id: "", title: "", location:  CLLocation(latitude: 32.88507, longitude: -117.24046), price: "", startDate: Date(), endDate: Date(),duration: "", details: ""
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
