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
                    .padding(.bottom, 20)

                ConfirmTitleSection(game: createGameViewModel.newGame)
                    .padding(.bottom, 20)

                ConfirmGameDetails(game: createGameViewModel.newGame)
                    .padding(.bottom, 20)
                    
                ConfirmInvitedPlayers(samplePlayers: $samplePlayers)
                    .padding(.bottom, 20)
                
                MapGameView()
                    .frame(height: 400)
                    .padding(.bottom, 20)
                
                ConfirmButtons(game: createGameViewModel.newGame)
                    .padding(.top)
            }
            .font(.system(size: 16))
            .padding()
            .onAppear {
                print(createGameViewModel.newGame)
            }
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

struct CoverImage: View {
    var body: some View {
        AsyncImage(url: URL(string: "https//example.com/icon.png"))  { phase in
            if let image = phase.image {
                image
            } else {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundColor(Color.ui.grayF6F6F6)
            }
        }
        .frame(height: 212)
    }
}

struct ConfirmTitleSection: View {
    let game: Game
    
    var date: String {
        return "\(game.date.formatted(date: .abbreviated, time: .omitted)) at \(game.startTime.formatted(date: .omitted, time: .shortened)) - \(game.endTime.formatted(date: .omitted, time: .shortened))"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(game.title)
                .font(.system(size: 24))
                .bold()
                .padding(.bottom, 5)
            
            Text(date)
                .padding(.bottom, 4)
                .font(.system(size: 16, weight: .medium))
            
            Text("\(game.place) \(game.address ?? "")")
                .font(.system(size: 16, weight: .medium))
        }
    }
}

struct ConfirmGameDetails: View {
    let game: Game
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Game Details")
                .font(.system(size: 20))
                .bold()
                .padding(.bottom, 5)
            
            Text(game.details)
                .padding(.bottom, 10)
            
            TagView(tags: game.getTagList())
                .font(.footnote)
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
                .padding(.bottom, 8)
            
            HStack(spacing: 4) {
                Text("10")
                Text("Players Maximum")
                    .foregroundColor(.gray)
            }
            .font(.system(size: 12))
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
