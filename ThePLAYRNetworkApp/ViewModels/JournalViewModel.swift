//
//  JournalViewModel.swift
//  ThePLAYRNetworkApp
//

//  Created by Timmy Nguyen on 10/23/22.

//

import Foundation

class JournalViewModel: ObservableObject {
//    @Published var courtData = Court.sampleCourtData
    @Published var selectedDisplay: Int = 0 // 0 is ratio, 1 is percentage
    @Published var selectedNotes: Int = 0
    @Published var selectedDateType: Int = 0

    
    @Published var currentJournal = Journal.sampleJournal
    @Published var selectedCourtSection: CourtSection = .leftCorner
    @Published var selection: Int = -1
    @Published var selectedDate = Date()

}
