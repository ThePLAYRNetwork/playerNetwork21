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
struct Game: Hashable, Identifiable { // remove hashable?
    var id: String
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
    
    var recordID: CKRecord.ID {
        CKRecord.ID(recordName: id)
    }
    
    init(title: String = "", place: String = "", location: CLLocation = CLLocation(), capacity: Int = 0, date: Date = Date(), startTime: Date = Date(), endTime: Date = Date(), details: String = "", playerLevel: PlayerLevel = .recreation, coverImage: CKAsset? = nil, isIndoor: Bool = false, isSpectatorAllowed: Bool = false, isPrivateGame: Bool = false) {
        self.id = UUID().uuidString
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
    }
    
//    init(record: CKRecord) throws {
//
//    }

    func createGameRecord() async throws -> CKRecord {
        let record = CKRecord(recordType: "Game", recordID: self.recordID)
        record[.title] = self.title
        record[.place] = self.place
        record[.location] = self.location
        record[.capacity] = self.capacity
        record[.date] = self.date
        record[.startTime] = self.startTime
        record[.endTime] = self.endTime
        record[.details] = self.details
        record[.playerLevel] = self.playerLevel.rawValue
//        record[.coverImage] = ...
        record[.isIndoor] = self.isIndoor
        record[.isSpectatorAllowed] = self.isSpectatorAllowed
        record[.isPrivateGame] = self.isPrivateGame
        
        return record
    }
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
    
    struct RecordError: LocalizedError {
        var localizedDescription: String
        
        static func missingKey(_ key: RecordKey) -> RecordError {
            RecordError(localizedDescription: "Missing required key \(key.rawValue)")
        }
    }
    
    enum RecordKey: String {
        case title, place, location, capacity, date, startTime, endTime, details, playerLevel, coverImage, isIndoor, isSpectatorAllowed, isPrivateGame
    }
    
    static let sampleGames: [Game] = [
        Game(title: "Tournament Round 3", place: "RIMAC Arena", location: CLLocation(), capacity: 10, date: Date(), startTime: Date(), endTime: Date(), details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ", playerLevel: .competitive, coverImage: nil, isIndoor: true, isSpectatorAllowed: true, isPrivateGame: true)
    ]
    
    
    // MARK - Helpers
    
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

