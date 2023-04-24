//
//  CreateGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/28/22.
//

import SwiftUI
import MapKit

// Note:
// - date center start, end right align, capacity 0 - 30
// - get address and get coordinates. still let user adjust pin
struct CreateGameView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var createViewModel : CreateGameViewModel
    @ObservedObject var coverImageViewModel = CoverImageViewModel()


    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Create Game")
                        .font(.system(size: 24))
                        .bold()
                        .padding(.top)
                    
                    GameTextField(
                        text: $createViewModel.newGame.title,
                        title: "Game Name",
                        placeholder: "Friendly Pick Up"
                    )
                    
                    HStack {
                        GameTextField(
                            text: $createViewModel.newGame.place,
                            title: "Location",
                            placeholder: "Ex. Courts",
                            image: Image("location")
                        )
                        .frame(width: geometry.size.width * 0.60)
                        
                        GameCapacityMenu(
                            capacity: $createViewModel.newGame.capacity,
                            title: "Game Capacity",
                            placeholder: 0
                        )
                    }
                    
//                    HStack {
//                        GameTextField(
//                            text: $createViewModel.newGame.title,
//                            title: "Date",
//                            placeholder: "MM/DD/YY",
//                            image: Image("calendar")
//                        )
//                        .frame(width: geometry.size.width * 0.35)
//
//                        GameTextField(
//                            text: $createViewModel.newGame.title,
//                            title: "Start",
//                            placeholder: "00:00",
//                            image: Image("duration")
//                        )
//
//                        GameTextField(
//                            text: $createViewModel.newGame.title,
//                            title: "End",
//                            placeholder: "00:00",
//                            image: Image("duration")
//                        )
//                    }
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Date".uppercased())
                                .font(.system(size: 12, weight: .medium))
                            
                            DatePicker(
                                "",
                                selection: $createViewModel.newGame.date,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                        }
                        
//                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Start".uppercased())
                                .font(.system(size: 12, weight: .medium))
                            
                            DatePicker(
                                "",
                                selection: $createViewModel.newGame.startTime,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("End".uppercased())
                                .font(.system(size: 12, weight: .medium))
                            
                            DatePicker(
                                "",
                                selection: $createViewModel.newGame.endTime,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                        }
                    }
                    

                    GameTextField(
                        text: $createViewModel.newGame.details,
                        title: "Details",
                        placeholder: "List any details important to this game."
                    )
                    
                    PlayerLevelRow(selection: $createViewModel.newGame.playerLevel)
                    
                    CoverImageRow()
                    
                    GameOptions(game: $createViewModel.newGame)
                    
                    Button {
                        navigationModel.path.append(GameDestination.confirmGame)
                    } label: {
                        Text("Continue")
                    }
//                    .disabled(isDisabled())
//                    .opacity(isDisabled() ? 0.5 : 1.0)
                    .frame(maxWidth: .infinity, alignment: .trailing)
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
                .environmentObject(CreateGameViewModel(gameRepository: GameRepository(), navigationModel: NavigationModel()))
        }
        .previewInterfaceOrientation(.portrait)
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
                        .foregroundColor(selection == .recreation ? Color.ui.accent : Color.ui.grayF6F6F6)

                }
                .disabled(selection == .recreation)
                
                Button(action: { selection = .competitive }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text(Game.PlayerLevel.competitive.rawValue.capitalized)
                                .foregroundColor(selection == .competitive ? Color.white : .gray)
                        }
                        .foregroundColor(selection == .competitive ? Color.ui.accent : Color.ui.grayF6F6F6)
                }
                .disabled(selection == .competitive)

                Button(action: { selection = .elite }) {
                    RoundedRectangle(cornerRadius: 40, style: .continuous)
                        .overlay {
                            Text(Game.PlayerLevel.elite.rawValue.capitalized)
                                .foregroundColor(selection == .elite ? Color.white : .gray)
                        }
                        .foregroundColor(selection == .elite ? Color.ui.accent : Color.ui.grayF6F6F6)
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

struct GameTextField: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var image: Image?
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .medium))
            
            HStack {
                image
                
                TextField(
                    placeholder,
                    text: $text
                )
            }
            .modifier(CreateLabel())
        }
    }
}

//struct CreateButton: View {
//    @EnvironmentObject var createViewModel: CreateGameViewModel
//    
//    var body: some View {
//        HStack {
//            Spacer()
//            Button(action: {}) {
//                NavigationLink(destination: ConfirmGameView(game: $createViewModel.newGame)
//                    .environmentObject(createViewModel)) {
//                        Text("Create")
//                            .foregroundColor(.white)
//                            .padding([.vertical], 7)
//                            .padding([.horizontal], 15)
//                            .background {
//                                RoundedRectangle(cornerRadius: 10, style: .continuous)
//                                    .foregroundColor(Color("red"))
//                            }
//                    }
//            }
////            .disabled(validateInput(game: createViewModel.game))
////            .opacity(validateInput(game: createViewModel.game) ? 0.5 : 1.0)
//        }
//    }
//}

struct GameCapacityMenu: View {
    @Binding var capacity: Int
    let title: String
    let placeholder: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .medium))
            
            Menu {
                //  Picker(selection: $user.height, label: EmptyView()) {
                Picker("Game Capacity", selection: $capacity) {
                    ForEach(0..<11) {
                        Text("\($0)")
                    }
                }
                
            } label: {
                HStack {
                    Text("\(capacity)")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .frame(width: 12, height: 6)
                }
                .modifier(CreateLabel())

            }
        }
    }
}
