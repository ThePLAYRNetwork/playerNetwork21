//
//  UpcomingGameItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI

struct UpcomingGameItem: View {
    let game: Game
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image("basketball")
                    .resizable()
                    .opacity(0.65)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(game.startDate)
                            .font(.system(size: 20))
                            .bold()
                        
                        Text("\(game.startTime) - \(game.endTime)")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Text(game.title)
                            .fontWeight(.bold)
                        
                        Text(game.location)
                            .fontWeight(.semibold)
                    }
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .padding()
                    
                    Spacer()
                }
            }
            .frame(width: 295, height: 163)
            
            VStack {
                HStack {
                    Text("12 Joined")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.ui.black)
                    Spacer()
                    PlayerAttendingCircles()
                }
                .padding()
                .frame(width: 295, height: 77)
                .background {
                    Rectangle()
                        .foregroundColor(Color.ui.grayF6F6F6)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
        .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)  // drop shadow
    }
}

struct UpcomingGameItem_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingGameItem(game: Game.sampleGames[0])
    }
}
