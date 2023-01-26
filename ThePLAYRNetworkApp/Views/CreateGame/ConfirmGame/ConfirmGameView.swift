//
//  ConfirmGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/2/22.
//

import SwiftUI

struct ConfirmGameView: View {
    @EnvironmentObject var createGameViewModel: CreateViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @Binding var game: Game
    @State var samplePlayers = User.sampleUsers.map { $0.name }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                CoverImage()
                
                ConfirmTitleSection(game: game)

                ConfirmGameDetails(game: game)
                
                ConfirmInvitedPlayers(samplePlayers: $samplePlayers)
                
                MapGameView()
                    .frame(height: 400)
                    .padding(.bottom, 20)
                
                ConfirmButtons(game: game)
            }
            .font(.system(size: 16))
            .padding()
            .navigationTitle("Confirm Game")
        }
    }
    
}

struct ConfirmGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ConfirmGameView(game: .constant(Game.sampleGames[0]))
                .environmentObject(CreateViewModel())
                .environmentObject(HomeViewModel())
                .environmentObject(AuthViewModel())
        }
    }
}

struct CoverImage: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .foregroundColor(Color.ui.grayD9D9D9)
            .frame(height: 212)
            .padding(.bottom, 20)
    }
}

struct ConfirmTitleSection: View {
    let game: Game
    
    var body: some View {
        Text(game.title)
            .font(.system(size: 24))
            .bold()
            .padding(.bottom, 5)
        
        Text("\(game.startDate) at \(game.startTime) - \(game.endTime)")
            .padding(.bottom, 4)
        
        Text(game.location)
            .padding(.bottom, 20)
    }
}

struct ConfirmGameDetails: View {
    let game: Game
    
    var body: some View {
        Text("Game Details")
            .font(.system(size: 20))
            .bold()
            .padding(.bottom, 5)
        
        Text(game.description)
            .padding(.bottom)
        
        HStack(spacing: 4) {
            Text("10")
            Text("Players Maximum")
                .foregroundColor(.gray)
        }
        .font(.system(size: 12))
        
        TagView(tags: game.getTagList())
            .font(.footnote)
            .padding(.bottom, 20)
    }
}

struct ConfirmInvitedPlayers: View {
    @Binding var samplePlayers: [String]
    
    var body: some View {
        Text("Invited Players")
            .font(.system(size: 20))
            .bold()
            .padding(.bottom, 7)
        
        InvitedTagView(players: $samplePlayers)
            .padding(.bottom, 20)
    }
}

struct ConfirmButtons: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var createGameViewModel: CreateViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    let game: Game
    
    var body: some View {
        HStack {
            Spacer()
//            Button(action: { dismiss() }) {
//                Text("Back")
//                    .bold()
//                    .foregroundColor(.black)
//            }
//            .padding([.top, .bottom], 7)
//            .padding([.leading, .trailing], 30)
//            .overlay(RoundedRectangle(cornerRadius: 7, style: .continuous)
//                .stroke(.black, lineWidth: 2))
//
            NavigationLink(destination: HomeView()) {
                Text("Create")
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 7)
                    .padding([.leading, .trailing], 30)
                    .background {
                        RoundedRectangle(cornerRadius: 7, style: .continuous)
                            .foregroundColor(Color.ui.primary)
                    }
                    .onTapGesture {
                        dismiss()
                        createGameViewModel.createGame(game: game)
                        homeViewModel.showingGamePosted = true
                        authViewModel.selection = Tab.home
                    }
            }
        }
    }
}
