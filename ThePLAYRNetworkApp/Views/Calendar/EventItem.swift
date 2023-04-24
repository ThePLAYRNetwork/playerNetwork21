//
//  EventItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/12/22.
//

import SwiftUI

struct EventItem: View {
    let game: Game
    
    var day: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: game.date)
        return components.day ?? 0
    }
    
    var dayOfWeekShorten: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let dayOfWeek = formatter.string(from: game.date)
        return dayOfWeek
    }
    
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            
//            VStack {
//                Text(game.getStartDay())
//                    .font(.system(size: 28))
//                    .fontWeight(.semibold)
//                
//                Text(game.dayOfWeek().uppercased())
//                    .font(.system(size: 12))
//                    .fontWeight(.medium)
//                
//            }
            
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color("orange"))
                        .frame(maxWidth: .infinity, maxHeight: 70)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text(game.getStartEndTime())
                            .font(.system(size: 12))
                        
                        Text(game.title)
                            .fontWeight(.semibold)
                        
                        Text(game.place)
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.white)
                    .padding()
                    
                }
                
            }

        }

    }
}

struct EventItem_Previews: PreviewProvider {
    static var previews: some View {
        EventItem(game: Game.sampleGames[0])
    }
}
