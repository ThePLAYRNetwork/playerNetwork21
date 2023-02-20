//
//  GameApiService.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 2/19/23.
//

import Foundation

protocol GameApiService {
    func fetchNearByGames() async -> [Game]
    
    func createGame() async
    
    func joinGame() async
}
