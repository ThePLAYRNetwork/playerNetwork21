//
//  TrainingSession.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/6/22.
//

import Foundation

enum Day: String, CaseIterable, Identifiable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    var id: Self { self }
}

struct TrainingSessionCollection: Identifiable {
    var id = UUID() // change later
    var data: [TrainingSession]
}

struct TrainingSession: Identifiable {
    var id = UUID() // change later
    let day: Day
    var times: [SessionTime]
    var repeatOption: RepeatOption = .every_day // default
}

struct SessionTime: Identifiable {
    var id = UUID() // change later
    var start: Date
    var end: Date
    
    func formattedSessionTime() -> String {
        return "\(start.formatted(date: .omitted, time: .shortened)) - \(end.formatted(date: .omitted, time: .shortened))"
    }
}

extension TrainingSessionCollection {
    static let sampleData = [
        TrainingSession(day: .monday, times: []),
        TrainingSession(day: .tuesday, times: [SessionTime(start: Date(), end: Date())]),
        TrainingSession(day: .wednesday, times: []),
        TrainingSession(day: .thursday, times: []),
        TrainingSession(day: .friday, times: []),
        TrainingSession(day: .saturday, times: []),
        TrainingSession(day: .sunday, times: [])
    ]
    
    static let sampleSession = TrainingSessionCollection(data: sampleData)

}
