//
//  Journal.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/10/23.
//

import Foundation
import CloudKit

struct Journal {
    var id: String
    var date: Date
    
    var leftCornerScore: Int
    var leftShortCornerScore: Int
    var paintScore: Int
    var rightShortCornerScore: Int
    var rightCornerScore: Int
    var middleMidRangeScore: Int
    var leftMidRangeScore: Int
    var freeThrowScore: Int
    var rightMidRangeScore: Int
    var leftWingScore: Int
    var leftShotScore: Int
    var topOfTheKeyScore: Int
    var rightShotScore: Int
    var rightWingScore: Int
    
    var leftCornerAttempt: Int
    var leftShortCornerAttempt: Int
    var paintAttempt: Int
    var rightShortCornerAttempt: Int
    var rightCornerAttempt: Int
    var middleMidRangeAttempt: Int
    var leftMidRangeAttempt: Int
    var freeThrowAttempt: Int
    var rightMidRangeAttempt: Int
    var leftWingAttempt: Int
    var leftShotAttempt: Int
    var topOfTheKeyAttempt: Int
    var rightShotAttempt: Int
    var rightWingAttempt: Int
    
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    init(date: Date = Date(),
         leftCornerScore: Int = 0, leftShortCornerScore: Int = 0, paintScore: Int = 0,
         rightShortCornerScore: Int = 0, rightCornerScore: Int = 0, middleMidRangeScore: Int = 0,
         leftMidRangeScore: Int = 0, freeThrowScore: Int = 0, rightMidRangeScore: Int = 0,
         leftWingScore: Int = 0, leftShotScore: Int = 0, topOfTheKeyScore: Int = 0,
         rightShotScore: Int = 0, rightWingScore: Int = 0,
         leftCornerAttempt: Int = 0, leftShortCornerAttempt: Int = 0, paintAttempt: Int = 0,
         rightShortCornerAttempt: Int = 0, rightCornerAttempt: Int = 0, middleMidRangeAttempt: Int = 0,
         leftMidRangeAttempt: Int = 0, freeThrowAttempt: Int = 0, rightMidRangeAttempt: Int = 0,
         leftWingAttempt: Int = 0, leftShotAttempt: Int = 0, topOfTheKeyAttempt: Int = 0,
         rightShotAttempt: Int = 0, rightWingAttempt: Int = 0) {
        self.id = UUID().uuidString
        self.date = date
        self.leftCornerScore = leftCornerScore
        self.leftShortCornerScore = leftShortCornerScore
        self.paintScore = paintScore
        self.rightShortCornerScore = rightShortCornerScore
        self.rightCornerScore = rightCornerScore
        self.middleMidRangeScore = middleMidRangeScore
        self.leftMidRangeScore = leftMidRangeScore
        self.freeThrowScore = freeThrowScore
        self.rightMidRangeScore = rightMidRangeScore
        self.leftWingScore = leftWingScore
        self.leftShotScore = leftShotScore
        self.topOfTheKeyScore = topOfTheKeyScore
        self.rightShotScore = rightShotScore
        self.rightWingScore = rightWingScore
        self.leftCornerAttempt = leftCornerAttempt
        self.leftShortCornerAttempt = leftShortCornerAttempt
        self.paintAttempt = paintAttempt
        self.rightShortCornerAttempt = rightShortCornerAttempt
        self.rightCornerAttempt = rightCornerAttempt
        self.middleMidRangeAttempt = middleMidRangeAttempt
        self.leftMidRangeAttempt = leftMidRangeAttempt
        self.freeThrowAttempt = freeThrowAttempt
        self.rightMidRangeAttempt = rightMidRangeAttempt
        self.leftWingAttempt = leftWingAttempt
        self.leftShotAttempt = leftShotAttempt
        self.topOfTheKeyAttempt = topOfTheKeyAttempt
        self.rightShotAttempt = rightShotAttempt
        self.rightWingAttempt = rightWingAttempt
    }
    
    init(record: CKRecord) throws {
        guard let date = record["date"] as? Date else {
            throw RecordError.missingKey(.date)
        }
        
        guard let leftCornerScore = record["leftCornerScore"] as? Int else {
            throw RecordError.missingKey(.leftCornerScore)
        }
        
        guard let leftShortCornerScore = record["leftShortCornerScore"] as? Int else {
            throw RecordError.missingKey(.leftShortCornerScore)
        }
        
        guard let paintScore = record["paintScore"] as? Int else {
            throw RecordError.missingKey(.paintScore)
        }
        
        guard let rightShortCornerScore = record["rightShortCornerScore"] as? Int else {
            throw RecordError.missingKey(.rightShortCornerScore)
        }
        
        guard let rightCornerScore = record["rightCornerScore"] as? Int else {
            throw RecordError.missingKey(.rightCornerScore)
        }
        
        guard let middleMidRangeScore = record["middleMidRangeScore"] as? Int else {
            throw RecordError.missingKey(.middleMidRangeScore)
        }
        
        guard let leftMidRangeScore = record["leftMidRangeScore"] as? Int else {
            throw RecordError.missingKey(.leftMidRangeScore)
        }
        
        guard let freeThrowScore = record["freeThrowScore"] as? Int else {
            throw RecordError.missingKey(.freeThrowScore)
        }
        
        guard let rightMidRangeScore = record["rightMidRangeScore"] as? Int else {
            throw RecordError.missingKey(.rightMidRangeScore)
        }
        
        guard let leftWingScore = record["leftWingScore"] as? Int else {
            throw RecordError.missingKey(.leftWingScore)
        }
        
        guard let leftShotScore = record["leftShotScore"] as? Int else {
            throw RecordError.missingKey(.leftShotScore)
        }
        
        guard let topOfTheKeyScore = record["topOfTheKeyScore"] as? Int else {
            throw RecordError.missingKey(.topOfTheKeyScore)
        }
        
        guard let rightShotScore = record["rightShotScore"] as? Int else {
            throw RecordError.missingKey(.rightShotScore)
        }
        
        guard let rightWingScore = record["rightWingScore"] as? Int else {
            throw RecordError.missingKey(.rightWingScore)
        }
        
        guard let leftCornerAttempt = record["leftCornerAttempt"] as? Int else {
            throw RecordError.missingKey(.leftCornerAttempt)
        }
        
        guard let leftShortCornerAttempt = record["leftShortCornerAttempt"] as? Int else {
            throw RecordError.missingKey(.leftShortCornerAttempt)
        }
        
        guard let paintAttempt = record["paintAttempt"] as? Int else {
            throw RecordError.missingKey(.paintAttempt)
        }
        
        guard let rightShortCornerAttempt = record["rightShortCornerAttempt"] as? Int else {
            throw RecordError.missingKey(.rightShortCornerAttempt)
        }
        
        guard let rightCornerAttempt = record["rightCornerAttempt"] as? Int else {
            throw RecordError.missingKey(.rightCornerAttempt)
        }
        
        guard let middleMidRangeAttempt = record["middleMidRangeAttempt"] as? Int else {
            throw RecordError.missingKey(.middleMidRangeAttempt)
        }
        
        guard let leftMidRangeAttempt = record["leftMidRangeAttempt"] as? Int else {
            throw RecordError.missingKey(.leftMidRangeAttempt)
        }
        
        guard let freeThrowAttempt = record["freeThrowAttempt"] as? Int else {
            throw RecordError.missingKey(.freeThrowAttempt)
        }
        
        guard let rightMidRangeAttempt = record["rightMidRangeAttempt"] as? Int else {
            throw RecordError.missingKey(.rightMidRangeAttempt)
        }
        
        guard let leftWingAttempt = record["leftWingAttempt"] as? Int else {
            throw RecordError.missingKey(.leftWingAttempt)
        }
        
        guard let leftShotAttempt = record["leftShotAttempt"] as? Int else {
            throw RecordError.missingKey(.leftShotAttempt)
        }
        
        guard let topOfTheKeyAttempt = record["topOfTheKeyAttempt"] as? Int else {
            throw RecordError.missingKey(.topOfTheKeyAttempt)
        }
        
        guard let rightShotAttempt = record["rightShotAttempt"] as? Int else {
            throw RecordError.missingKey(.rightShotAttempt)
        }
        
        guard let rightWingAttempt = record["rightWingAttempt"] as? Int else {
            throw RecordError.missingKey(.rightWingAttempt)
        }
        
        self.id = record.recordID.recordName
        self.date = date
        self.leftCornerScore = leftCornerScore
        self.leftShortCornerScore = leftShortCornerScore
        self.paintScore = paintScore
        self.rightShortCornerScore = rightShortCornerScore
        self.rightCornerScore = rightCornerScore
        self.middleMidRangeScore = middleMidRangeScore
        self.leftMidRangeScore = leftMidRangeScore
        self.freeThrowScore = freeThrowScore
        self.rightMidRangeScore = rightMidRangeScore
        self.leftWingScore = leftWingScore
        self.leftShotScore = leftShotScore
        self.topOfTheKeyScore = topOfTheKeyScore
        self.rightShotScore = rightShotScore
        self.rightWingScore = rightWingScore
        self.leftCornerAttempt = leftCornerAttempt
        self.leftShortCornerAttempt = leftShortCornerAttempt
        self.paintAttempt = paintAttempt
        self.rightShortCornerAttempt = rightShortCornerAttempt
        self.rightCornerAttempt = rightCornerAttempt
        self.middleMidRangeAttempt = middleMidRangeAttempt
        self.leftMidRangeAttempt = leftMidRangeAttempt
        self.freeThrowAttempt = freeThrowAttempt
        self.rightMidRangeAttempt = rightMidRangeAttempt
        self.leftWingAttempt = leftWingAttempt
        self.leftShotAttempt = leftShotAttempt
        self.topOfTheKeyAttempt = topOfTheKeyAttempt
        self.rightShotAttempt = rightShotAttempt
        self.rightWingAttempt = rightWingAttempt
    }
    
    func createJournalRecord() throws -> CKRecord {
        let record = CKRecord(recordType: "Journal", recordID: self.recordID)
        record[RecordKey.date] = self.date
        record[RecordKey.leftCornerScore] = self.leftCornerScore
        record[RecordKey.leftShortCornerScore] = self.leftShortCornerScore
        record[RecordKey.paintScore] = self.paintScore
        record[RecordKey.rightShortCornerScore] = self.rightShortCornerScore
        record[RecordKey.rightCornerScore] = self.rightCornerScore
        record[RecordKey.middleMidRangeScore] = self.middleMidRangeScore
        record[RecordKey.leftMidRangeScore] = self.leftMidRangeScore
        record[RecordKey.freeThrowScore] = self.freeThrowScore
        record[RecordKey.rightMidRangeScore] = self.rightMidRangeScore
        record[RecordKey.leftWingScore] = self.leftWingScore
        record[RecordKey.leftShotScore] = self.leftShotScore
        record[RecordKey.topOfTheKeyScore] = self.topOfTheKeyScore
        record[RecordKey.rightShotScore] = self.rightShotScore
        record[RecordKey.rightWingScore] = self.rightWingScore
        record[RecordKey.leftCornerAttempt] = self.leftCornerAttempt
        record[RecordKey.leftShortCornerAttempt] = self.leftShortCornerAttempt
        record[RecordKey.paintAttempt] = self.paintAttempt
        record[RecordKey.rightShortCornerAttempt] = self.rightShortCornerAttempt
        record[RecordKey.rightCornerAttempt] = self.rightCornerAttempt
        record[RecordKey.middleMidRangeAttempt] = self.middleMidRangeAttempt
        record[RecordKey.leftMidRangeAttempt] = self.leftMidRangeAttempt
        record[RecordKey.freeThrowAttempt] = self.freeThrowAttempt
        record[RecordKey.rightMidRangeAttempt] = self.rightMidRangeAttempt
        record[RecordKey.leftWingAttempt] = self.leftWingAttempt
        record[RecordKey.leftShotAttempt] = self.leftShotAttempt
        record[RecordKey.topOfTheKeyAttempt] = self.topOfTheKeyAttempt
        record[RecordKey.rightShotAttempt] = self.rightShortCornerAttempt
        record[RecordKey.rightWingAttempt] = self.rightWingAttempt
        
        return record
    }
}

extension Journal {
    static private var sampleScores = [5, 3, 4, 5, 2, 3, 4, 2, 2, 5, 3, 3, 6, 5]
    static private var sampleAttempts = [7, 4, 4, 8, 5, 7, 4, 6, 3, 9, 10, 3, 7, 7]
    static var sampleJournal = Journal(date: Date())
    
    enum RecordKey: String {
        case date, leftCornerScore, leftShortCornerScore, paintScore, rightShortCornerScore, rightCornerScore, middleMidRangeScore, leftMidRangeScore, freeThrowScore, rightMidRangeScore, leftWingScore, leftShotScore, topOfTheKeyScore, rightShotScore, rightWingScore, leftCornerAttempt, leftShortCornerAttempt, paintAttempt, rightShortCornerAttempt, rightCornerAttempt, middleMidRangeAttempt, leftMidRangeAttempt, freeThrowAttempt, rightMidRangeAttempt, leftWingAttempt, leftShotAttempt, topOfTheKeyAttempt, rightShotAttempt, rightWingAttempt
    }
    
    struct RecordError: LocalizedError {
        var localizedDescription: String
        
        static func missingKey(_ key: RecordKey) -> RecordError {
            RecordError(localizedDescription: "Missing required key \(key.rawValue)")
        }
    }
}

extension CKRecord {
    subscript(key: Journal.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}

enum CourtSection: String, CaseIterable, Identifiable {
    case leftCorner = "Left Corner"
    case leftShortCorner = "Left Short Corner"
    case paint = "Paint"
    case rightShortCorner = "Right Short Corner"
    case rightCorner = "Right Corner"
    case middleMidRange = "Middle Mid Range"
    case leftMidRange = "Left Mid Range"
    case freeThrow = "Free Throw"
    case rightMidRange = "Right Mid Range"
    case leftWing = "Left Wing"
    case leftShot = "Left Shot"
    case topOfTheKey = "Top of the Key"
    case rightShot = "Right Shot"
    case rightWing = "Right Wing"
    var id: Self { self }
}
