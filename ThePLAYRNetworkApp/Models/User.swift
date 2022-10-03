//
//  User.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var username: String
    
    init(id: String = "", name: String = "", email: String = "", username: String = "") {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
    }
}

//         let players: [String] = ["Kevin J. Adams", "Tony Chen", "Charles Do", "Hector Ferguson"]

extension User {
    static let sampleUser = User(id: "daj90sdjdjas9", name: "Timmy Nguyen", email: "timmypass17@gmail.com", username: "timmypass17")
    static let sampleUsers: [User] = [
        User(id: "1", name: "Kevin J. Adams"),
        User(id: "2", name: "Tony Chen"),
        User(id: "3", name: "Charles Do"),
        User(id: "4", name: "Hector Ferguson")
    ]
}
