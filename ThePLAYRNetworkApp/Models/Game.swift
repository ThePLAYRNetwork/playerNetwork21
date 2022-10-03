//
//  Game.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation

struct Game: Codable {
    var id: String
    var startDate: String
    var startTime: String
    var endTime: String
    var title: String
    var description: String
    var location: String
    var playerIDs: [String]
    var creatorID: String
    var type: String
    var sport: String
    var city: String
    var geohash: String
    var longitude: Double
    var latitude: Double
    var playerLevel: String
    var isIndoor: Bool
    var spectatorsAllowed: Bool
    var isPublic: Bool
    var capacity: String
    
    init(id: String = "", startDate: String = "", startTime: String = "", endTime: String = "", title: String = "", description: String = "", location: String = "", players: [String] = [], creatorID: String = "", type: String = "", sport: String = "", city: String = "", geohash: String = "", longitude: Double = 0.0, latitude: Double = 0.0, playerLevel: String = "Anyone", isIndoor: Bool = false, spectatorsAllowed: Bool = false, isPublic: Bool = false, capacity: String = "") {
        self.id = id
        self.startDate = startDate
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
        self.description = description
        self.location = location
        self.playerIDs = players
        self.creatorID = creatorID
        self.type = type
        self.sport = sport
        self.city = city
        self.geohash = geohash
        self.longitude = longitude
        self.latitude = latitude
        self.playerLevel = playerLevel
        self.isIndoor = false
        self.spectatorsAllowed = false
        self.isPublic = false
        self.capacity = capacity
    }
    
    func getTagList() -> [String] {
        var tags: [String] = []
        
        tags.append(self.playerLevel)
        tags.append(self.isIndoor ? "Indoor" : "Outdoor")
        tags.append(self.spectatorsAllowed ? "Spectators Allowed": "No Spectators")
        tags.append(self.isPublic ? "Public": "Private")
        
        return tags
    }
}

extension Game {
    static let sampleGames: [Game] = [
        Game(
            id: "ao2h123iu2h",
            startDate: "July 29",
            startTime: "5:00 PM",
            endTime: "6:30 PM",
            title: "Tournament Round 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",location: "RIMAC Arena",
            type: "5v5",
            sport: "Basketball"
        ),
        Game(id: "ads09adu0s", startDate: "July 23", startTime: "5:00 PM", title: "Game 2", location: "Thurgood Marshall college"),
        Game(id: "sad8asaduw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego"),
        Game(id: "sasad8asdaauw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego"),
        Game(id: "sasadsd8auw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego"),
        Game(id: "sad8asdauw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego"),
        Game(id: "sadasd8auw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego"),
        Game(id: "sadsaad8auw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego"),
        Game(id: "saasdd8auw9da", startDate: "July 26", startTime: "6:00 PM", title: "Game 3", location: "UC San Diego")
    ]
}
