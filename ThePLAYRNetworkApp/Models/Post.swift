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
    static let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."
    
    static let samplePosts: [Post] = [
        Post(id: "1", message: text),
        Post(id: "2", message: text)
    ]
}
