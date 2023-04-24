//
//  CalendarViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 4/19/23.
//

import Foundation
import Combine


@MainActor
class CalendarViewModel: ObservableObject {
    @Published var upcomingGames: [Game] = []
    
    var gameRepository: GameRepository  // published?
    private var cancellables = Set<AnyCancellable>()
    
    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository
        
        // upcomingGames listen to any updates to repository games.
        // note: should update repository, not viewmodel's games so that other views that listens to repo's game can receive same updates.
        self.gameRepository.$games
            .assign(to: \.upcomingGames, on: self)
            .store(in: &cancellables)
        
    }
}
