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
                Text("Confirm Game")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.bottom, 20)
                
                CoverImage()
                
                ConfirmTitleSection(game: game)

                ConfirmGameDetails(game: game)
                
                ConfirmInvitedPlayers(samplePlayers: $samplePlayers)
                    .padding(.top, 20)
                
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundColor(Color("light_gray"))
                    .frame(height: 100)
                    .padding(.top, 19)
                
//                MapGameView()
//                    .frame(height: 400)
//                    .padding(.bottom, 20)
                
                ConfirmButtons(game: game)
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
            .foregroundColor(Color("light_gray"))
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
            .font(.system(size: 16, weight: .medium))
        
        Text(game.location)
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
            
            Text(game.description)
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
                    .onTapGesture {
                        dismiss()
                        createGameViewModel.createGame(game: game)
                        homeViewModel.showingGamePosted = true
                        authViewModel.selection = Tab.home
                    }
            }
            .buttonStyle(CustomButton(color: .red, size: .small))
        }
    }
}
