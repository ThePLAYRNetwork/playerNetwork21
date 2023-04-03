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
    
    func fetchNearByGames() async -> [Game]
    
    func joinGame() async
}


class GameRepository: ObservableObject, GameApiService {
    
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
    
    func fetchNearByGames() async -> [Game] {
        return []
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
