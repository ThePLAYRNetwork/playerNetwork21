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
    var scores: [Int]
    var attempts: [Int]
    var date: Date
}

enum CourtSection: String, CaseIterable, Identifiable {
    case leftCorner = "Left Corner"
    case leftShortCorner = "Left Short Corner"
    case paint = "Paint"
    case rightShortCorner = "Right Short Corner"
    case rightCorner = "Right Corner"
    case leftMidRange = "Left Mid Range"
    case rightMidRange = "Right Mid Range"
    case freeThrow = "Free Throw"
    case middleMidRange = "Middle Mid Range"
    case leftWing = "Left Wing"
    case topOfTheKey = "Top of the Key"
    case rightWing = "Right Wing"
    case leftShot = "Left Shot"
    case rightShot = "Right Shot"
    var id: Self { self }
}
