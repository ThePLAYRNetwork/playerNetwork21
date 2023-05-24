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
    
    @Published var startDate = Date()
    @Published var endDate = Date().addingTimeInterval(605800) // 7 days ahead
    @Published var journalData: [Journal] = []
    @Published var chartData: [JournalChartEntry] = []
    
    var journalRepository: JournalRepository
    
    
    init(journalRepository: JournalRepository) {
        self.journalRepository = journalRepository
//        self.$journalData
//            .sink { [self] journals in
//                switch selectedCourtSection {
//                case .leftCorner:
//                    chartData = journalData.map { JournalChartEntry(score: $0.leftShotScore, attempt: $0.leftShotAttempt, date: $0.date) }
//                case .leftShortCorner:
//                    chartData = journalData.map { JournalChartEntry(score: $0.leftShortCornerScore, attempt: $0.leftShortCornerAttempt, date: $0.date) }
//                case .paint:
//                    chartData = journalData.map { JournalChartEntry(score: $0.paintScore, attempt: $0.paintAttempt, date: $0.date) }
//                case .rightShortCorner:
//                    chartData = journalData.map { JournalChartEntry(score: $0.rightShortCornerScore, attempt: $0.rightShortCornerAttempt, date: $0.date) }
//                case .rightCorner:
//                    chartData = journalData.map { JournalChartEntry(score: $0.rightCornerScore, attempt: $0.rightCornerAttempt, date: $0.date) }
//                case .middleMidRange:
//                    chartData = journalData.map { JournalChartEntry(score: $0.middleMidRangeScore, attempt: $0.middleMidRangeAttempt, date: $0.date) }
//                case .leftMidRange:
//                    chartData = journalData.map { JournalChartEntry(score: $0.leftMidRangeScore, attempt: $0.leftMidRangeAttempt, date: $0.date) }
//                case .freeThrow:
//                    chartData = journalData.map { JournalChartEntry(score: $0.freeThrowScore, attempt: $0.freeThrowAttempt, date: $0.date) }
//                case .rightMidRange:
//                    chartData = journalData.map { JournalChartEntry(score: $0.rightMidRangeScore, attempt: $0.rightMidRangeAttempt, date: $0.date) }
//                case .leftWing:
//                    chartData = journalData.map { JournalChartEntry(score: $0.leftWingScore, attempt: $0.leftWingAttempt, date: $0.date) }
//                case .leftShot:
//                    chartData = journalData.map { JournalChartEntry(score: $0.leftShotScore, attempt: $0.leftShotAttempt, date: $0.date) }
//                case .topOfTheKey:
//                    chartData = journalData.map { JournalChartEntry(score: $0.topOfTheKeyScore, attempt: $0.topOfTheKeyAttempt, date: $0.date) }
//                case .rightShot:
//                    chartData = journalData.map { JournalChartEntry(score: $0.rightShotScore, attempt: $0.rightShotAttempt, date: $0.date) }
//                case .rightWing:
//                    chartData = journalData.map { JournalChartEntry(score: $0.rightWingScore, attempt: $0.rightWingAttempt, date: $0.date) }
//                }
//            }
        
        Task {
            // Initalize journal with today's journal entry if it exists
            await getJournalEntry(date: Date())
        }
    }
    
    func getJournalEntries(startDate: Date, endDate: Date) async {
        let result = await journalRepository.getJournalEntries(startDate: startDate, endDate: endDate)
        switch result {
        case .success(let journals):
            self.journalData = journals
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
    
    func getStartDateRange() -> ClosedRange<Date> {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = -5
        let start = calendar.date(byAdding: dateComponents, to: endDate)!
        return start...endDate
    }
    
    // calendar range is closed range, used arbitrarily 5 years
    func getEndDateRange() -> ClosedRange<Date> {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 5
        let end = calendar.date(byAdding: dateComponents, to: startDate)!
        return startDate...end
    }
}

