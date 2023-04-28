//
//  Journal.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/10/23.
//

import Foundation
import CloudKit

struct Journal {
    var recordName: String
    var userID: CKRecord.Reference
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
    
    init(userID: CKRecord.Reference, date: Date,
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
        self.recordName = UUID().uuidString
        self.userID = userID
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
}

extension Journal {
    static private var sampleScores = [5, 3, 4, 5, 2, 3, 4, 2, 2, 5, 3, 3, 6, 5]
    static private var sampleAttempts = [7, 4, 4, 8, 5, 7, 4, 6, 3, 9, 10, 3, 7, 7]
    static var sampleJournal = Journal(userID: CKRecord.Reference(record: CKRecord(recordType: "Journal"), action: .none), date: Date(), leftCornerScore: 5, leftCornerAttempt: 7)
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
