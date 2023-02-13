//
//  InvitePlayersView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/17/22.
//

import SwiftUI

struct InvitePlayersView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State var players: [User] = User.sampleUsers
    @State var invitedPlayers: Set<String> = [] // user id's
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(players, id: \.id) { player in
                InvitePlayersItem(invitedPlayers: $invitedPlayers, player: player)
            }
            Spacer()
            HStack {
                Spacer()
                DoneButton()
            }
        }
        .searchable(
            text: $text,
            prompt: "Search Names"
        )
        .padding()
        .navigationTitle("Invite Players")
    }
}

struct InvitePlayersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InvitePlayersView(players: User.sampleUsers)
        }
        .previewInterfaceOrientation(.portrait)
    }
}

struct DoneButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Text("Done")
            .foregroundColor(.white)
            .padding([.top, .bottom], 7)
            .padding([.leading, .trailing], 30)
            .background {
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .foregroundColor(Color.ui.accentColor)
            }
            .onTapGesture {
                dismiss()
            }
    }
}
