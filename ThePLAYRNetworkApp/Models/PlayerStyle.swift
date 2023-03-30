//
//  PlayerStyle.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/16/23.
//

import Foundation
import CloudKit

struct PlayerStyle: Identifiable {
    var id: String
    var name: String
    var playerImage: CKAsset
    
    init(record: CKRecord) throws {
        guard let name = record[.name] as? String else {
            throw RecordError.missingKey(.name)
        }
        
        guard let playerImage = record[.playerImage] as? CKAsset else {
            throw RecordError.missingKey(.playerImage)
        }
        
        self.id = record.recordID.recordName
        self.name = name
        self.playerImage = playerImage
    }
}

extension PlayerStyle {
    enum RecordKey: String {
        case name, playerImage
    }
    
    struct RecordError: LocalizedError {
        var localizedDescription: String
        
        static func missingKey(_ key: RecordKey) -> RecordError {
            RecordError(localizedDescription: "Missing required key \(key.rawValue)")
        }
    }
}

extension CKRecord {
    subscript(key: PlayerStyle.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
