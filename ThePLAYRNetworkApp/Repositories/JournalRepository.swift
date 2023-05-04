//
//  JournalRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/30/23.
//

import Foundation
import CloudKit

enum JournalError: Error {
    case badDate
    case badSave
}

class JournalRepository: ObservableObject {
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    func saveJournalEntry(journal: Journal) async -> Result<Journal, Error> {
        print("Saving journal for date: \(journal.date.formatted(date: .abbreviated, time: .omitted))")
        do {
            // Check if journal entry exists
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: journal.date)
            guard let startDate = Calendar.current.date(from: dateComponents),
                  let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else { return .failure(JournalError.badDate) }
            
            let userID = try await container.userRecordID()
            let predicate = NSPredicate(format: "date >= %@ AND date < %@ AND creatorUserRecordID == %@", startDate as NSDate, endDate as NSDate, userID)
            let query = CKQuery(recordType: "Journal", predicate: predicate)
            
            let (results, _) = try await database.records(matching: query, resultsLimit: 1)
            if let record = try results.first?.1.get() {
                // Handle existing journal entry case (fetch record if it exists, modifiy existing record, save record)
                record[Journal.RecordKey.date] = journal.date
                record[Journal.RecordKey.leftCornerScore] = journal.leftCornerScore
                record[Journal.RecordKey.leftShortCornerScore] = journal.leftShortCornerScore
                record[Journal.RecordKey.paintScore] = journal.paintScore
                record[Journal.RecordKey.rightShortCornerScore] = journal.rightShortCornerScore
                record[Journal.RecordKey.rightCornerScore] = journal.rightCornerScore
                record[Journal.RecordKey.middleMidRangeScore] = journal.middleMidRangeScore
                record[Journal.RecordKey.leftMidRangeScore] = journal.leftMidRangeScore
                record[Journal.RecordKey.freeThrowScore] = journal.freeThrowScore
                record[Journal.RecordKey.rightMidRangeScore] = journal.rightMidRangeScore
                record[Journal.RecordKey.leftWingScore] = journal.leftWingScore
                record[Journal.RecordKey.leftShotScore] = journal.leftShotScore
                record[Journal.RecordKey.topOfTheKeyScore] = journal.topOfTheKeyScore
                record[Journal.RecordKey.rightShotScore] = journal.rightShotScore
                record[Journal.RecordKey.rightWingScore] = journal.rightWingScore
                record[Journal.RecordKey.leftCornerAttempt] = journal.leftCornerAttempt
                record[Journal.RecordKey.leftShortCornerAttempt] = journal.leftShortCornerAttempt
                record[Journal.RecordKey.paintAttempt] = journal.paintAttempt
                record[Journal.RecordKey.rightShortCornerAttempt] = journal.rightShortCornerAttempt
                record[Journal.RecordKey.rightCornerAttempt] = journal.rightCornerAttempt
                record[Journal.RecordKey.middleMidRangeAttempt] = journal.middleMidRangeAttempt
                record[Journal.RecordKey.leftMidRangeAttempt] = journal.leftMidRangeAttempt
                record[Journal.RecordKey.freeThrowAttempt] = journal.freeThrowAttempt
                record[Journal.RecordKey.rightMidRangeAttempt] = journal.rightMidRangeAttempt
                record[Journal.RecordKey.leftWingAttempt] = journal.leftWingAttempt
                record[Journal.RecordKey.leftShotAttempt] = journal.leftShotAttempt
                record[Journal.RecordKey.topOfTheKeyAttempt] = journal.topOfTheKeyAttempt
                record[Journal.RecordKey.rightShotAttempt] = journal.rightShortCornerAttempt
                record[Journal.RecordKey.rightWingAttempt] = journal.rightWingAttempt
                
                try await database.save(record)
                print("Journal modified successfully")
                return .success(journal)
            }
            
            // Handle new journal entry (save it)
            let record = try journal.createJournalRecord()
            try await database.save(record)
            print("Journal saved successfully")
            return .success(journal)
            
        } catch {
            print("Failed to save journal: \(error)")
            return .failure(error)
        }
    }
    
    func getJournalEntry(startDate: Date, endDate: Date) async -> Result<Journal, Error> {
        do {
            print(startDate.formatted(date: .abbreviated, time: .omitted))
            print(endDate.formatted(date: .abbreviated, time: .omitted))
            
            let userID = try await container.userRecordID()
            let predicate = NSPredicate(format: "date >= %@ AND date <= %@ AND creatorUserRecordID == %@",
                                        startDate as NSDate, endDate as NSDate, userID)
            let query = CKQuery(recordType: "Journal", predicate: predicate)
            
            let (results, _) = try await database.records(matching: query)
            print("Number of records between \(startDate.formatted(date: .abbreviated, time: .omitted)) and \(endDate.formatted(date: .abbreviated, time: .omitted)): \(results.count)")
            if let record = try results.first?.1.get() {
                print("Successfully found journal entry")
                return .success(try Journal(record: record)) // existing journal
            } else {
                print("No journal entry found")
                return .success(Journal())    // empty journal
            }
            
        } catch {
            print("Erroring fetching journal entry: \(error)")
            return .failure(error)
        }
    }
    
    func getJournalEntry(date: Date) async -> Result<Journal, Error> {
        do {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            guard let startDate = Calendar.current.date(from: dateComponents),
                  let endDate = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else { return .failure(JournalError.badDate) }

            let userID = try await container.userRecordID()
            let predicate = NSPredicate(format: "date >= %@ AND date < %@ AND creatorUserRecordID == %@", startDate as NSDate, endDate as NSDate, userID)
            let query = CKQuery(recordType: "Journal", predicate: predicate)

            let (results, _) = try await database.records(matching: query, resultsLimit: 1)
            if let record = try results.first?.1.get() {
                print("Successfully found journal entry")
                return .success(try Journal(record: record)) // existing journal
            } else {
                print("No journal entry found")
                return .success(Journal(date: date))    // empty journal
            }

        } catch {
            print("Erroring fetching journal entry: \(date)")
            return .failure(error)
        }
    }
}
