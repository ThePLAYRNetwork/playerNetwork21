//
//  GameRepository.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 2/19/23.
//

import Foundation
import CloudKit

protocol GameApiService {
    func createGame(game: Game) async -> Result<Game, Error>
    
//    func fetchNearByGames() async -> [Game]
    
    func joinGame() async
}


class GameRepository: ObservableObject, GameApiService {
    @Published var games: [Game] = [] 
    
    private lazy var container: CKContainer = CKContainer.default()
    private lazy var database: CKDatabase = container.publicCloudDatabase
    
    func createGame(game: Game) async -> Result<Game, Error> {
        do {
            let record = try await game.createGameRecord()
            let userRecord = try await database.save(record)
            print("Game created successfully:\n\(userRecord)")
            return .success(game)
        } catch {
            print("Failed to create game: \(error)")
            return .failure(error)
        }
    }
    
    func fetchNearByGames(location: CLLocation) async -> Result<[Game], Error> {
        let radius = 10000 // meters
        let predicate = NSPredicate(format: "distanceToLocation:fromLocation:(location, %@) < %f", location, radius)
        let query = CKQuery(recordType: "Game", predicate: predicate)
        
        do {
            var (gameResults, _) = try await database.records(matching: query, resultsLimit: 10)
            
            let games: [Game] = gameResults
                .compactMap { _, result in
                    guard let record = try? result.get() else { return nil }
                    return try? Game(record: record)
                }
            print("Sucessfully got nearby games")
            return .success(games)
            
        } catch {
            print("Failed to get nearby games: \(error)")
            return .failure(error)
        }
    }
    
    
    func joinGame() async {
        
    }
    
}

extension CKRecord {
    subscript(key: Game.RecordKey) -> Any? {
        get { return self[key.rawValue] }
        set { self[key.rawValue] = newValue as? CKRecordValue}
    }
}
