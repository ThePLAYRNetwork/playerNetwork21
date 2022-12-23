//
//  Note.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/13/22.
//

import Foundation

struct Note: Identifiable {
    let id = UUID()
    var text: String
    let createdAt: Date
}
