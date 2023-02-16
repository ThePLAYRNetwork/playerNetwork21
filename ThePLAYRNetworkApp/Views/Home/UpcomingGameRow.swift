//
//  UpcomingGameRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI
import MapKit

struct UpcomingGameRow: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    var categoryName: String
    var items: [Game]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text(categoryName)
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(.leading, 20)
                .padding(.bottom, 13)
                .foregroundColor(Color.ui.black)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 15) { // could use reg
                    ForEach(items, id: \.id) { game in
                        
                        // Old navigation, inefficient. It creates the game detail view for each item.
//                        NavigationLink {
//                            GameDetailView(game: game)
//                        } label: {
//                            UpcomingGameItem(game: game)
//                        }
                        
                        // New navigaiton way
                        NavigationLink(value: game) {
                            UpcomingGameItem(game: game)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
                .padding(.bottom, 5) // to show shadow
                .frame(height: 250)
            }
        }
//        .frame(height: 300)
    }
}

struct UpcomingGameRow_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingGameRow(categoryName: "Nearby Games", items: Game.sampleGames)
    }
}
