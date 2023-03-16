//
//  InvitePlayersItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/17/22.
//

import SwiftUI

struct InvitePlayersItem: View {
    @Binding var invitedPlayers: Set<String>
    let player: User
    
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(Color.ui.grayD9D9D9)
                .frame(width: 46, height: 46)
            Text(player.firstName)
            Spacer()
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 8, height: 8)
                .foregroundColor(invitedPlayers.contains(player.id) ? .white : .clear)
                .background {
                    Circle()
                        .strokeBorder(.gray, lineWidth: 1)
                        .background(invitedPlayers.contains(player.id) ? Circle().fill(Color.ui.accent) : Circle().fill(.clear))
                        .frame(width: 19, height: 19)
                }
        }
        .padding(.trailing)
        .buttonStyle(PlainButtonStyle())
        .contentShape(Rectangle())
        .onTapGesture {
            handleButton(player: player)
        }
    }
    
    private func handleButton(player: User) {
        // If user is invited already, remove from list
        if invitedPlayers.contains(player.id) {
            invitedPlayers.remove(player.id)
        } else {
            invitedPlayers.insert(player.id)
        }
    }
}

struct InvitePlayersItem_Previews: PreviewProvider {
    static var previews: some View {
        InvitePlayersItem(invitedPlayers: .constant(Set<String>()), player: User.sampleUsers[0])
    }
}
