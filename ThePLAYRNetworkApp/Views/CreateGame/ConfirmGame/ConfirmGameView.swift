//
//  ConfirmGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/2/22.
//

import SwiftUI

struct ConfirmGameView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var createGameViewModel: CreateGameViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var samplePlayers = User.sampleUsers.map { $0.firstName }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Confirm Game")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 20)
                
                CoverImage()
                
                ConfirmTitleSection(game: createGameViewModel.newGame)

                ConfirmGameDetails(game: createGameViewModel.newGame)
                
                ConfirmInvitedPlayers(samplePlayers: $samplePlayers)
                    .padding(.top, 20)
                
                MapGameView()
                    .frame(height: 400)
                    .padding(.bottom, 20)
                
                ConfirmButtons(game: createGameViewModel.newGame)
                    .padding(.top)
            }
            .font(.system(size: 16))
            .padding()
        }
    }
    
}

struct ConfirmGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConfirmGameView()
                .environmentObject(CreateGameViewModel(gameRepository: GameRepository(), navigationModel: NavigationModel()))
                .environmentObject(HomeViewModel(gameRepository: GameRepository(), sessionRepository: SessionRepository()))
        }
    }
}



struct ConfirmTitleSection: View {
    let game: Game
    
    var date: String {
        return "\(game.date.formatted(date: .abbreviated, time: .omitted)) at \(game.startTime.formatted(date: .omitted, time: .shortened)) - \(game.endTime.formatted(date: .omitted, time: .shortened))"
    }
    
    var body: some View {
        Text(game.title)
            .font(.system(size: 24))
            .bold()
            .padding(.bottom, 5)
    
        Text(date)
            .padding(.bottom, 4)
            .font(.system(size: 16, weight: .medium))
        
        Text(game.place)
            .font(.system(size: 16, weight: .medium))
            .padding(.bottom, 20)
    }
}

struct ConfirmGameDetails: View {
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Game Details")
                .font(.system(size: 20))
                .bold()
            
            Text(game.details)
                .padding(.top, 5)
            
            TagView(tags: game.getTagList())
                .font(.footnote)
                .padding(.top, 10)
        }
    }
}

struct ConfirmInvitedPlayers: View {
    @Binding var samplePlayers: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Invited Players")
                .font(.system(size: 20))
                .bold()
                .padding(.bottom, 7)
            
            InvitedTagView(players: $samplePlayers)
            
            HStack(spacing: 4) {
                Text("10")
                Text("Players Maximum")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 12))
            .padding(.top, 8)
        }
    }
}

struct ConfirmButtons: View {
//    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var createGameViewModel: CreateGameViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var navigationModel: NavigationModel

    let game: Game
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                Task {
                    await createGameViewModel.createGame()
                }
            } label: {
                Text("Create")
            }
            .buttonStyle(CustomButton(color: .red, size: .small))
        }
    }
}
