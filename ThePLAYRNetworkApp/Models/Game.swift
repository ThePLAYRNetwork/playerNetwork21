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
    var address: String
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
    
    init(title: String = "", place: String = "", address: String = "", location: CLLocation = CLLocation(), capacity: Int = 0, date: Date = Date(), startTime: Date = Date().nearestHour(), endTime: Date = Date().nearestHour(), details: String = "", playerLevel: PlayerLevel = .recreation, coverImage: CKAsset? = nil, isIndoor: Bool = false, isSpectatorAllowed: Bool = false, isPrivateGame: Bool = false) {
        self.id = UUID().uuidString
        self.title = title
        self.place = place
        self.address = address
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
    
    init(record: CKRecord) throws {
        guard let title = record[Game.RecordKey.title] as? String else {
            throw RecordError.missingKey(.title)
        }
        
        guard let place = record[Game.RecordKey.place] as? String else {
            throw RecordError.missingKey(.place)
        }
        
        guard let address = record[Game.RecordKey.address] as? String else {
            throw RecordError.missingKey(.address)
        }
        
        guard let location = record[Game.RecordKey.location] as? CLLocation else {
            throw RecordError.missingKey(.location)
        }
        
        guard let capacity = record[Game.RecordKey.capacity] as? Int else {
            throw RecordError.missingKey(.capacity)
        }
        
        guard let date = record[Game.RecordKey.date] as? Date else {
            throw RecordError.missingKey(.date)
        }
        
        guard let startTime = record[Game.RecordKey.startTime] as? Date else {
            throw RecordError.missingKey(.startTime)
        }
        
        guard let endTime = record[Game.RecordKey.endTime] as? Date else {
            throw RecordError.missingKey(.endTime)
        }
        
        guard let details = record[Game.RecordKey.details] as? String else {
            throw RecordError.missingKey(.details)
        }
        
        guard let playerLevelString = record[Game.RecordKey.playerLevel] as? String,
              let playerLevel = PlayerLevel(rawValue: playerLevelString)
        else {
            throw RecordError.missingKey(.playerLevel)
        }
        
        if let coverImage = record[Game.RecordKey.coverImage] as? CKAsset {
            self.coverImage = coverImage
        }
        
        guard let isIndoor = record[Game.RecordKey.isIndoor] as? Bool else {
            throw RecordError.missingKey(.isIndoor)
        }
        
        guard let isSpectatorAllowed = record[Game.RecordKey.isSpectatorAllowed] as? Bool else {
            throw RecordError.missingKey(.isSpectatorAllowed)
        }
        
        guard let isPrivateGame = record[Game.RecordKey.isPrivateGame] as? Bool else {
            throw RecordError.missingKey(.isPrivateGame)
        }
        
        self.id = record.recordID.recordName
        self.title = title
        self.place = place
        self.address = address
        self.location = location
        self.capacity = capacity
        self.date = date
        self.startTime = startTime
        self.endTime = endTime
        self.details = details
        self.playerLevel = playerLevel
        self.isIndoor = isIndoor
        self.isSpectatorAllowed = isSpectatorAllowed
        self.isPrivateGame = isPrivateGame
    }

    func createGameRecord() async throws -> CKRecord {
        let record = CKRecord(recordType: "Game", recordID: self.recordID)
        record[Game.RecordKey.title] = self.title
        record[Game.RecordKey.place] = self.place
        record[Game.RecordKey.address] = self.address
        record[Game.RecordKey.location] = self.location
        record[Game.RecordKey.capacity] = self.capacity
        record[Game.RecordKey.date] = self.date
        record[Game.RecordKey.startTime] = self.startTime
        record[Game.RecordKey.endTime] = self.endTime
        record[Game.RecordKey.details] = self.details
        record[Game.RecordKey.playerLevel] = self.playerLevel.rawValue
//        record[Game.RecordKey.coverImage] = ...
        record[Game.RecordKey.isIndoor] = self.isIndoor
        record[Game.RecordKey.isSpectatorAllowed] = self.isSpectatorAllowed
        record[Game.RecordKey.isPrivateGame] = self.isPrivateGame        
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
        case title, place, address, location, capacity, date, startTime, endTime, details, playerLevel, coverImage, isIndoor, isSpectatorAllowed, isPrivateGame
    }
    
    static let sampleGames: [Game] = [
        Game(title: "Pickup Game",
             place: "Muir Courts",
             address: "9730 Hopkins Dr, La Jolla, CA 92093",
             location: CLLocation(latitude: 32.88507, longitude: -117.24046),
             capacity: 10,
             date: Date().addingTimeInterval(-86400),
             startTime: Date(),
             endTime: Date(),
             details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
             playerLevel: .competitive,
             coverImage: nil,
             isIndoor: true,
             isSpectatorAllowed: true,
             isPrivateGame: true),
        Game(title: "Open Gym",
             place: "RIMAC Arena",
             address: "9730 Hopkins Dr, La Jolla, CA 92093",
             location: CLLocation(latitude: 32.88507, longitude: -117.24046),
             capacity: 10,
             date: Date().addingTimeInterval(86400 * 2),
             startTime: Date(),
             endTime: Date(),
             details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
             playerLevel: .competitive,
             coverImage: nil,
             isIndoor: true,
             isSpectatorAllowed: true,
             isPrivateGame: true),
        Game(title: "Tournament Round 1",
             place: "RIMAC Arena",
             address: "9730 Hopkins Dr, La Jolla, CA 92093",
             location: CLLocation(latitude: 32.88507, longitude: -117.24046),
             capacity: 10,
             date: Date().addingTimeInterval(86400 * 5),
             startTime: Date().addingTimeInterval(-3600),
             endTime: Date(),
             details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
             playerLevel: .competitive,
             coverImage: nil,
             isIndoor: true,
             isSpectatorAllowed: true,
             isPrivateGame: true),
        Game(title: "Tournament Round 2",
             place: "RIMAC Arena",
             address: "9730 Hopkins Dr, La Jolla, CA 92093",
             location: CLLocation(latitude: 32.88507, longitude: -117.24046),
             capacity: 10,
             date: Date().addingTimeInterval(86400 * 5),
             startTime: Date(),
             endTime: Date(),
             details: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
             playerLevel: .competitive,
             coverImage: nil,
             isIndoor: true,
             isSpectatorAllowed: true,
             isPrivateGame: true)
    ]
    
    
    // MARK - Helpers
    
    func getStartDay() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        return components.day?.description ?? "N/A"
    }
    
    func dayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" // Wed
        let dayOfWeek = formatter.string(from: date)
        return dayOfWeek
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
    
    func getStartEndTime() -> String {
        return "\(startTime.formatted(date: .omitted, time: .shortened)) - \(endTime.formatted(date: .omitted, time: .shortened))"
    }
    
    func formattedDetailsTime() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"    // startTime.description = "2023-01-29 23:16:38 +0000"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "E MMM dd"  // Wed Jan 29
        
        if let date = dateFormatterGet.date(from: startTime.description) {
            return "\(dateFormatterPrint.string(from: date)) at \(getStartEndTime())"
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

extension Date {
    func nearestHour() -> Date {
        var components = NSCalendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute >= 30 ? 60 - minute : -minute
        return Calendar.current.date(byAdding: components, to: self) ?? Date()
    }
}
