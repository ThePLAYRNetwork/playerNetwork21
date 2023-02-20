//
//  GameDetailTopSection.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/8/23.
//

import SwiftUI

struct GameDetailTopSection: View {
    let game: Game
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(game.title)
                .font(.system(size: 24, weight: .semibold))
            
            Text(game.formattedDetailsTime())
                .padding(.top, 2)
                .font(.system(size: 16, weight: .medium))
            
            Text(game.place)
                .padding(.top, 4)
                .font(.system(size: 16, weight: .medium))
            
            HStack(spacing: 4) {
                Text("Organized by")
                    .foregroundColor(Color.ui.gray959595)
                
                Text("Charles Do")
            }
            .font(.system(size: 12))
            .padding(.top, 5)
            
            Text("Kevin & 12 others are going")
                .font(.system(size: 12))
                .padding(.top, 20)
            
            HStack {
                VStack(alignment: .leading) {
                    PlayerAttendingCirclesSmall()
                }
                
                NavigationLink(destination: GoingView()) {
                    Text("Show".uppercased())
                        .font(.system(size: 12))
                }
                
                Spacer()
                
                Button(action: {}) {
                    Text("Join Game")
                        .bold()
                }
                .buttonStyle(CustomButton(color: .red, size: .small))
                
                Button(action: {}) {
                    Image("share_button")
                        .resizable()
                        .frame(width: 33, height: 33)
                }
            }
            .padding(.top, 8)
        }
        .padding()
    }
}

struct GameDetailTopSection_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailTopSection(game: Game.sampleGames[0])
    }
}
