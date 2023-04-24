//
//  Note.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/13/22.
//

import Foundation
import CloudKit

struct Note {
    var recordName: String
    var message: String
    var createdAt: Date
}

extension Note {
    static let sampleNotes: [Note] = [
        Note(recordName: "", message: "", createdAt: Date())
    ]
}
