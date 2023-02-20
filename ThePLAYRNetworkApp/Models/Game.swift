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
struct Game: Identifiable, Hashable {
    var id: UUID
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
    var invitedPlayers: [CKRecord.Reference]
    
    // init default values here so that it is not required when creating game object
    init(id: UUID = UUID(), title: String = "", place: String = "", location: CLLocation = CLLocation(latitude: 0.0, longitude: 0.0), capacity: Int = 0, date: Date = Date(), startTime: Date = Date(), endTime: Date = Date(), details: String = "", playerLevel: PlayerLevel = .recreation, coverImage: CKAsset? = nil, isIndoor: Bool = false, isSpectatorAllowed: Bool = false, isPrivateGame: Bool = false, invitedPlayers: [CKRecord.Reference] = []) {
        self.id = id
        self.title = title
        self.place = place
        self.location = location
        self.capacity = capacity
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.details = details
        self.playerLevel = playerLevel
        self.coverImage = coverImage
        self.isIndoor = isIndoor
        self.isSpectatorAllowed = isSpectatorAllowed
        self.isPrivateGame = isPrivateGame
        self.invitedPlayers = invitedPlayers
    }

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

enum PlayerLevel: String {
    case recreation
    case competitive
    case elite
}

extension Game {
    static let sampleGames: [Game] = [
        Game(title: "Pickup Game",
             place: "RIMAC Courts",
             location: CLLocation(latitude: 37.319500230495414, longitude: -121.84947636614272),
             capacity: 10,
             date: Date(),
             startTime: Date(),
             endTime: Date(),
             details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
             playerLevel: .competitive,
             coverImage: nil,
             isIndoor: true,
             isSpectatorAllowed: true,
             isPrivateGame: true,
             invitedPlayers: []
            ),
        Game(title: "5v5",
             place: "Marshall Courts",
             location: CLLocation(latitude: 37.3205940066624, longitude: -121.85562468240302),
             capacity: 10,
             date: Date(),
             startTime: Date(),
             endTime: Date(),
             details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
             playerLevel: .competitive,
             coverImage: nil,
             isIndoor: true,
             isSpectatorAllowed: true,
             isPrivateGame: true,
             invitedPlayers: []
            )
    ]
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}
