//
//  Specialist.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/4/22.
//

import Foundation

struct Specialist: Identifiable {
    var id: UUID = UUID()
    var title: String
    var date: Date
    var location: String
    var trainer: String
    var price: Int
}

extension Specialist {
    static let sampleSpecialists = [
        Specialist(title: "Body Building Basics", date: Date(), location: "San Diego", trainer: "Jared Mills", price: 70),
        Specialist(title: "Powerlifting", date: Date(), location: "San Diego", trainer: "Christopher Jones", price: 50),
        Specialist(title: "Target Muscle Growth", date: Date(), location: "San Diego", trainer: "Ty Akins", price: 65)
    ]
}
