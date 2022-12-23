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

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Create Game")
                        .bold()
                        .font(.system(size: 24))
                        .padding(.vertical)

                    CreateGameTopSection(game: $createViewModel.game, geometry: geometry)
                        .padding(.bottom)
                    
                    PlayerLevelRow(selection: $createViewModel.game.playerLevel)
                        .padding(.bottom)
                    
                    CoverImageRow()
                        .padding(.bottom)

                    GameOptions(game: $createViewModel.game)
                        .padding(.bottom)
                    
                    CreateButton()
                }
                .padding()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
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

struct CreateGameTopSection: View {
    @Binding var game: Game
    var geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: . leading, spacing: 20) {
            VStack {
                TextField("Game Name", text: $game.title)
                    .foregroundColor(Color.ui.text_placeholder)
                Divider()
                    .overlay(.black)
            }
            .frame(width: geometry.size.width * 0.60)

            HStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        TextField("Location", text: $game.location)
                            .foregroundColor(Color.ui.text_placeholder)
                    }
                    Divider()
                        .overlay(.black)
                }
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                        TextField("MM/DD/YY", text: $game.startDate)
                            .foregroundColor(Color.ui.text_placeholder)
                    }
                    Divider()
                        .overlay(.black)
                }
                .frame(width: geometry.size.width * 0.40)

            }
            HStack(alignment: .bottom) {
                VStack {
                    HStack {
                        Image(systemName: "clock.fill")
                        TextField("Start", text: $game.startTime)
                            .foregroundColor(Color.ui.text_placeholder)
                    }
                    Divider()
                        .overlay(.black)
                }
                VStack {
                    HStack {
                        Image(systemName: "clock.fill")
                        TextField("End", text: $game.endTime)
                            .foregroundColor(Color.ui.text_placeholder)
                    }
                    Divider()
                        .overlay(.black)
                }
                
                VStack {
                    HStack {
                        Image(systemName: "chevron.up.chevron.down")
                        TextField("Game Capacity", text: $game.capacity)
                            .foregroundColor(Color.ui.text_placeholder)
                    }
                    Divider()
                        .overlay(.black)
                }
                .frame(width: geometry.size.width * 0.40)
            }
            VStack {
                // multiline support in iOS16
                TextField("Details", text: $game.description)
                    .foregroundColor(Color.ui.text_placeholder)
                Divider()
                    .overlay(.black)
            }
        }
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
            .foregroundColor(Color("lighter_gray"))
        }
    }
}

struct CoverImageRow_Previews: PreviewProvider {
    static var previews: some View {
        CoverImageRow()
            .previewLayout(.sizeThatFits)
    }
}


enum PlayerLevel : String{
    case anyone = "Anyone"
    case competitive = "Competitive"
    case elite = "Elite"
}

// Could use picker instead
struct PlayerLevelRow: View {
    @Binding var selection: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Player Level")
            HStack {
                Button(action: { selection = PlayerLevel.anyone.rawValue }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text("Anyone")
                                .foregroundColor(selection == PlayerLevel.anyone.rawValue ? Color.white : .gray)
                        }
                        .foregroundColor(selection == PlayerLevel.anyone.rawValue ? Color.ui.secondary : Color.ui.lighter_gray)
                }
                .disabled(selection == PlayerLevel.anyone.rawValue)
                
                Button(action: { selection = PlayerLevel.competitive.rawValue }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text("Competitive")
                                .foregroundColor(selection == PlayerLevel.competitive.rawValue ? Color.white : .gray)
                        }
                        .foregroundColor(selection == PlayerLevel.competitive.rawValue ? Color.ui.secondary : Color.ui.lighter_gray)
                }
                .disabled(selection == PlayerLevel.competitive.rawValue)

                Button(action: { selection = PlayerLevel.elite.rawValue }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text("Elite")
                                .foregroundColor(selection == PlayerLevel.elite.rawValue ? Color.white : .gray)
                        }
                        .foregroundColor(selection == PlayerLevel.elite.rawValue ? Color.ui.secondary : Color.ui.lighter_gray)
                }
                .disabled(selection == PlayerLevel.elite.rawValue)
            }
            .frame(height: 30)
            .font(.system(size: 12))
            .foregroundColor(Color("lighter_gray"))
        }
    }
}

struct PlayerLevelRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerLevelRow(selection: .constant("Anyone"))
            .previewLayout(.sizeThatFits)
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
                            .tint(Color.ui.secondary)
                    }
                    .padding([.trailing, .leading])
                }
                .foregroundColor(Color.ui.button_gray_background)

            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .overlay {
                    HStack {
                        Text("Spectators Allowed")
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("Spectators Allowed", isOn: $game.spectatorsAllowed)
                            .labelsHidden()
                            .tint(Color.ui.secondary)

                    }
                    .padding([.trailing, .leading])
                }
                .foregroundColor(Color.ui.button_gray_background)

            RoundedRectangle(cornerRadius: 8)
                .frame(height: 40)
                .overlay {
                    HStack {
                        Text("Public Game")
                            .foregroundColor(.black)
                        Spacer()
                        Toggle("Public Game", isOn: $game.isPublic)
                            .labelsHidden()
                            .tint(Color.ui.secondary)
                    }
                    .padding([.trailing, .leading])
                }
                .foregroundColor(Color.ui.button_gray_background)

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
                    .foregroundColor(Color.ui.button_gray_background)
            }
            .buttonStyle(PlainButtonStyle()) // rmeove default config
        }
    }
}

struct GameOptions_Previews: PreviewProvider {
    static var previews: some View {
        GameOptions(game: .constant(Game()))
            .previewLayout(.sizeThatFits)
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
            .disabled(validateInput(game: createViewModel.game))
            .opacity(validateInput(game: createViewModel.game) ? 0.5 : 1.0)
        }
    }
    
    // Return True if user input is invalid
    private func validateInput(game: Game) -> Bool {
        return game.title.isEmpty || game.location.isEmpty || game.startDate.isEmpty || game.startTime.isEmpty || game.endTime.isEmpty || game.capacity.isEmpty || game.description.isEmpty
    }
}
