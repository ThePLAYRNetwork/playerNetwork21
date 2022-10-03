//
//  NearbySessionsRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/18/22.
//

import SwiftUI
import MapKit

struct NearbySessionsRow: View {
   
    var categoryName: String
    var items: [Game]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .font(.system(size: 20))
                .bold()
                .padding(.leading, 20)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 15) { // could use reg
                    ForEach(items, id: \.id) { game in
                        NavigationLink {
                            GameDetailView(
                                game: game,
                                location: Location(
                                    name: game.title,
                                    coordinate: CLLocationCoordinate2D(
                    latitude: game.latitude, longitude: game.longitude))
                            )
                        } label: {
                            UpcomingGameItem(game: game)
                        }
                    }
                }
                .padding([.leading, .trailing], 20)
            }
        }
        .frame(height: 290)    }
}

struct NearbySessionsRow_Previews: PreviewProvider {
    static var previews: some View {
        NearbySessionsRow(categoryName: "Today's Hosted Games", items: Game.sampleGames)
    }
}
