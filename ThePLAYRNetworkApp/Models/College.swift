//
//  College.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/30/23.
//

import Foundation

struct College: Codable {
    var name: String
}

extension College {
    static let sampleColleges = [College(name: "UC San Diego"), College(name: "UC Berkeley"), College(name: "CSU East Bay"), College(name: "Evergreen Valley College")]
}
