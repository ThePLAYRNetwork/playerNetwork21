//
//  CreateGameView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/28/22.
//

import SwiftUI
import MapKit

// TODO: check if user selected location (make new published variable)
// Note:
// - date center start, end right align, capacity 0 - 30
// - get address and get coordinates. still let user adjust pin
// - auto fill location
// drop down menu
struct CreateGameView: View {
    enum Field: String, Hashable {
        case gameName
        case location
        case description
    }
    
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var createGameViewModel : CreateGameViewModel
    @FocusState private var focusedField: Field?
    @State var invalidTitle = false
    @State var invalidLocation = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Create Game")
                        .font(.system(size: 24))
                        .bold()
                        .padding(.top)
                    
                    GameTextField(
                        text: $createGameViewModel.newGame.title,
                        title: "Game Name",
                        placeholder: "Friendly Pick Up",
                        focusedField: _focusedField,
                        field: .gameName,
                        isInvalid: $invalidTitle
                    )
                    
                    HStack {
                        LocationSearchBar(
                            focusedField: _focusedField,
                            field: .location,
                            isInvalid: $invalidLocation
                        )
                        .frame(width: geometry.size.width * 0.60)
                        .focused($focusedField, equals: .location)
                        
                        Spacer()
                        
                        GameCapacityMenu(
                            capacity: $createGameViewModel.newGame.capacity,
                            title: "Game Capacity",
                            placeholder: 0
                        )
                        
                    }
                    .zIndex(1)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Date".uppercased())
                                .font(.system(size: 12, weight: .medium))
                            
                            DatePicker(
                                "",
                                selection: $createGameViewModel.newGame.date,
                                displayedComponents: .date
                            )
                            .labelsHidden()
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Start".uppercased())
                                .font(.system(size: 12, weight: .medium))
                            
                            DatePicker(
                                "",
                                selection: $createGameViewModel.newGame.startTime,
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
                                selection: $createGameViewModel.newGame.endTime,
                                displayedComponents: .hourAndMinute
                            )
                            .labelsHidden()
                        }
                    }
                    
                    GameTextField(
                        text: $createGameViewModel.newGame.details,
                        title: "Details",
                        placeholder: "List any details important to this game.",
                        focusedField: _focusedField,
                        field: .description,
                        isInvalid: .constant(false)
                    )
                    
                    PlayerLevelRow(selection: $createGameViewModel.newGame.playerLevel)
                    
                    GameCoverImageRow()
                    GameCoverImage()
                    
                    
                    GameOptions(game: $createGameViewModel.newGame)
                    
                    
                    Button {
                        invalidTitle = createGameViewModel.newGame.title.isEmpty
                        invalidLocation = createGameViewModel.locationSearchService.selectedCompletion == nil
                        
                        // Check for invalid inputs
                        if invalidTitle {
                            focusedField = .gameName
                        }
                        else if invalidLocation {
                            focusedField = .location
                        } else {
                            // Valid Input
                            Task {
                                await createGameViewModel.convertAddressToCoordinates()
                                navigationModel.gamePath.append(GameDestination.confirmGame)
                            }
                        }
                    } label: {
                        Text("Continue")
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .buttonStyle(CustomButton(color: .red, size: .small))
                    
                    
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
    @FocusState var focusedField: CreateGameView.Field?
    var field: CreateGameView.Field
    @Binding var isInvalid: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(title.uppercased())
                
                if isInvalid {
                    Text("Invalid Input".uppercased())
                        .foregroundColor(.red)
                }
            }
            .font(.system(size: 12, weight: .medium))
            
            HStack {
                image
                
                TextField(
                    placeholder,
                    text: $text
                )
                .focused($focusedField, equals: field)
                
            }
            .modifier(CreateLabel())
        }
    }
}

struct GameCapacityMenu: View {
    @Binding var capacity: Int
    let title: String
    let placeholder: Int
    let limit = 30
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .medium))
            
            Menu {
                //  Picker(selection: $user.height, label: EmptyView()) {
                Picker("Game Capacity", selection: $capacity) {
                    ForEach(0..<limit + 1) {
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
