//
//  CreateGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/28/22.
//

import SwiftUI
import MapKit

struct CreateGameView: View {
    @EnvironmentObject var createViewModel : CreateViewModel
    @State var gameName: String = ""
    @State var location: String = ""
    @State var price: String = ""
    @State var dateStart: String = ""
    @State var dateEnd: String = ""
    @State var duration: String = ""
    @State var details: String = ""
    @State var playerLevel: Game.PlayerLevel = .recreation
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Create Game")
                        .font(.system(size: 24))
                        .bold()
                        .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Game Name".uppercased())
                            .font(.system(size: 12))
                        
                        TextField(
                            "Training",
                            text: $gameName
                        )
                        .modifier(CreateLabel())
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Location".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("location")
                                TextField(
                                    "Ex. Courts",
                                    text: $location
                                )
                            }
                            .modifier(CreateLabel())
                        }
                        .frame(width: geometry.size.width * 0.60)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Game Capacity".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("location")
                                TextField(
                                    "$0.00",
                                    text: $price
                                )
                            }
                            .modifier(CreateLabel())
                        }
                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Date".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("calendar")
                                TextField(
                                    "MM/DD/YY",
                                    text: $dateStart
                                )
                            }
                            .modifier(CreateLabel())
                        }
                        .frame(width: geometry.size.width * 0.33)
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Start".uppercased())
                                .font(.system(size: 12))
                            
                            HStack {
                                Image("calendar")
                                TextField(
                                    "MM/DD/YY",
                                    text: $dateEnd
                                )
                            }
                            .modifier(CreateLabel())
                        }
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("End".uppercased())
                                .font(.system(size: 12))

                            HStack {
                                Image("duration")
                                TextField(
                                    "00.00",
                                    text: $duration
                                )
                            }
                            .modifier(CreateLabel())
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 3) {
                        Text("Details".uppercased())
                            .font(.system(size: 12))

                        TextField(
                            "List any details important to this session.",
                            text: $details,
                            axis: .vertical
                        )
                        .modifier(CreateLabel())
                    }
                    
                    PlayerLevelRow(selection: $playerLevel)
                    
                    CoverImageRow()
                    
                    GameOptions(game: $createViewModel.game)
                    
                    NavigationLink {
                        ConfirmGameView(game: $createViewModel.game)
                    } label: {
                        Text("Create")
                    }
                    .buttonStyle(CustomButton(color: .red, size: .small))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                .padding()
            }
        }
    }
}

struct CreateGameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateGameView()
                .environmentObject(CreateViewModel())
        }
        .previewInterfaceOrientation(.portrait)
    }
}

struct CoverImageRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Cover Image".uppercased())
                .font(.system(size: 12))

            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .aspectRatio(1.0, contentMode: .fit) // to keep square shape
                    .overlay {
                        Image("photos")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                            .foregroundColor(.gray)
                    }
                RoundedRectangle(cornerRadius: 4)
                    .aspectRatio(1.0, contentMode: .fit)
                    .overlay {
                        Image(systemName: "camera.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 34, height: 34)
                            .foregroundColor(.gray)
                    }
                RoundedRectangle(cornerRadius: 4)
                    .aspectRatio(1.0, contentMode: .fit)
                RoundedRectangle(cornerRadius: 4)
                    .aspectRatio(1.0, contentMode: .fit)
                
            }
            .foregroundColor(Color.ui.grayECECEC)
        }
    }
}

// Could use picker instead
struct PlayerLevelRow: View {
    @Binding var selection: Game.PlayerLevel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Player Level".uppercased())
                .font(.system(size: 12))

            HStack {
                Button(action: { selection = .recreation }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text(Game.PlayerLevel.recreation.rawValue.capitalized)
                                .foregroundColor(selection == .recreation ? Color.white : .gray)
                        }
                        .foregroundColor(selection == .recreation ? Color.ui.accent : Color.ui.grayD9D9D9)

                }
                .disabled(selection == .recreation)
                
                Button(action: { selection = .competitive }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text(Game.PlayerLevel.competitive.rawValue.capitalized)
                                .foregroundColor(selection == .competitive ? Color.white : .gray)
                        }
                        .foregroundColor(selection == .competitive ? Color.ui.accent : Color.ui.grayD9D9D9)
                }
                .disabled(selection == .competitive)

                Button(action: { selection = .elite }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text(Game.PlayerLevel.elite.rawValue.capitalized)
                                .foregroundColor(selection == .elite ? Color.white : .gray)
                        }
                        .foregroundColor(selection == .elite ? Color.ui.accent : Color.ui.grayD9D9D9)
                }
                .disabled(selection == .elite)
            }
            .frame(height: 30)
            .font(.system(size: 12))
            .foregroundColor(Color.ui.grayD9D9D9)
        }
    }
}

struct GameOptions: View {
    @Binding var game: Game
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .overlay {
                    HStack {
                        Text("Indoor")
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("Indoor", isOn: $game.isIndoor)
                            .labelsHidden()
                            .tint(Color.ui.accent)
                    }
                    .padding([.trailing, .leading])
                }
                .foregroundColor(Color.ui.grayF6F6F6)

            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .overlay {
                    HStack {
                        Text("Spectators Allowed")
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("Spectators Allowed", isOn: $game.isSpectatorAllowed)
                            .labelsHidden()
                            .tint(Color.ui.accent)

                    }
                    .padding([.trailing, .leading])
                }
                .foregroundColor(Color.ui.grayF6F6F6)

            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .overlay {
                    HStack {
                        Text("Public Game")
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("Public Game", isOn: $game.isPrivateGame)
                            .labelsHidden()
                            .tint(Color.ui.accent)
                    }
                    .padding([.trailing, .leading])
                }
                .foregroundColor(Color.ui.grayF6F6F6)

            NavigationLink(destination: InvitePlayersView()) {
                RoundedRectangle(cornerRadius: 8)
                    .frame(height: 40)
                    .overlay {
                        HStack {
                            Text("Invite Players")
                                .foregroundColor(.black)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding([.trailing, .leading])
                    }
                    .foregroundColor(Color.ui.grayF6F6F6)
            }
            .buttonStyle(PlainButtonStyle()) // rmeove default config
        }
    }
}

struct CreateButton: View {
    @EnvironmentObject var createViewModel: CreateViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                NavigationLink(destination: ConfirmGameView(game: $createViewModel.game)
                    .environmentObject(createViewModel)) {
                        Text("Create")
                            .foregroundColor(.white)
                            .padding([.vertical], 7)
                            .padding([.horizontal], 15)
                            .background {
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .foregroundColor(Color("red"))
                            }
                    }
            }
//            .disabled(validateInput(game: createViewModel.game))
//            .opacity(validateInput(game: createViewModel.game) ? 0.5 : 1.0)
        }
    }
    
    // Return True if user input is invalid
//    private func validateInput(game: Game) -> Bool {
//        return game.title.isEmpty || game.location.isEmpty || game.startDate.isEmpty || game.startTime.isEmpty || game.endTime.isEmpty || game.capacity.isEmpty || game.description.isEmpty
//    }
}
