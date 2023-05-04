//
//  JournalViewModel.swift
//  ThePLAYRNetworkApp
//

//  Created by Timmy Nguyen on 10/23/22.

//

import Foundation

@MainActor
class JournalViewModel: ObservableObject {
//    @Published var courtData = Court.sampleCourtData
    @Published var currentJournal = Journal(date: Date())
    @Published var displayedJournal = Journal(date: Date())
    @Published var selectedCourtSection: CourtSection = .leftCorner
    @Published var selection: Int = -1
    @Published var selectedDate = Date()
    @Published var selectedDisplay: Int = 0 // 0 is ratio, 1 is percentage
    @Published var selectedNotes: Int = 0
    @Published var selectedDateRange: DateRange = .day
    
    var journalRepository: JournalRepository
    
    init(journalRepository: JournalRepository) {
        self.journalRepository = journalRepository
        
        Task {
            // Initalize journal with today's journal entry if it exists
            await getJournalEntry(date: Date())
            
        }
    }
    
    func getJournalEntry(startDate: Date, endDate: Date) async {
        let result = await journalRepository.getJournalEntry(startDate: startDate, endDate: endDate)
        switch result {
        case .success(let journal):
            self.currentJournal = journal
            return
        case .failure(let error):
            return
        }
    }
    
    func getJournalEntry(date: Date) async {
        let result = await journalRepository.getJournalEntry(date: date)
        switch result {
        case .success(let journal):
            self.currentJournal = journal
            return
        case .failure(let error):
            return
        }
    }
    
    func saveJournalEntry(journal: Journal) async {
        let result = await journalRepository.saveJournalEntry(journal: journal)
        switch result {
        case .success(let journal):
            self.currentJournal = journal
            return
        case .failure(let error):
            return
        }
    }
}
