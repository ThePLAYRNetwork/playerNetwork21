//
//  Game.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation
import CoreLocation
import CloudKit

// must be hashable for new navigaiton destination
// cloudkit support data types: https://developer.apple.com/documentation/cloudkit/ckrecord
struct Game: Hashable {
    var recordName: String
    var title: String
    var place: String
    var location: CLLocation
    var capacity: Int
    var date: Date
    var startTime: Date
    var endTime: Date
    var details: String
    var playerLevel: PlayerLevel
    var coverImage: CKAsset?
    var isIndoor: Bool
    var isSpectatorAllowed: Bool
    var isPrivateGame: Bool
}

extension Game {
    struct InvitedPlayers {
        var recordName: String
        var gameID: CKRecord.Reference
        var userID: CKRecord.Reference
        var status: InviteStatus
    }

    enum InviteStatus {
        case accepted, pending, rejected
    }
    
    enum PlayerLevel: String {
        case recreation
        case competitive
        case elite
    }
    
    static let sampleGames: [Game] = [
        Game(recordName: "", title: "", place: "", location: CLLocation(latitude: CLLocationDegrees(), longitude: CLLocationDegrees()), capacity: 0, date: Date(), startTime: Date(), endTime: Date(), details: "", playerLevel: .competitive, isIndoor: true, isSpectatorAllowed: true, isPrivateGame: true)
    ]

    func getStartMonthDay() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"    // startTime.description = "2023-01-29 23:16:38 +0000"

        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"  // Jan 29
        
        if let date = dateFormatterGet.date(from: startTime.description) {
            return dateFormatterPrint.string(from: date)
        }
        
        return "No Date"
    }
    
    func formattedStartEndTime() -> String {
        return "\(startTime.formatted(date: .omitted, time: .shortened)) - \(endTime.formatted(date: .omitted, time: .shortened))"
    }
    
    func formattedDetailsTime() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"    // startTime.description = "2023-01-29 23:16:38 +0000"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E MMM dd"  // Wed Jan 29
        
        if let date = dateFormatterGet.date(from: startTime.description) {
            return "\(dateFormatterPrint.string(from: date)) at \(formattedStartEndTime())"
        }
        
        return "No Date"
    }
    
    func getTagList() -> [String] {
        var tags: [String] = []
        
        tags.append(playerLevel.rawValue.capitalized)
        tags.append(isIndoor ? "Indoor" : "Outdoor")
        tags.append(isSpectatorAllowed ? "Spectators Allowed": "No Spectators")
        tags.append(isPrivateGame ? "Private": "Public")
        
        return tags
    }
}



extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

