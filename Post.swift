//
//  Post.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/12/22.
//

import Foundation

struct Post: Codable {
    var id: String
    var message: String
    
    init(id: String = "", message: String = "") {
        self.id = id
        self.message = message
    }
}

extension Post {
    static let samplePosts: [Post] = [
        Post(id: "1", message: "Message 1."),
        Post(id: "2", message: "Message 2.")
    ]
}
