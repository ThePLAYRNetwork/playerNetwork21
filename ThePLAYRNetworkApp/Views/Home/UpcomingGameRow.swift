//
//  UpcomingGameRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI
import MapKit

struct UpcomingGameRow: View {
    var categoryName: String
    var items: [Game]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(categoryName)
                .font(.system(size: 20))
                .fontWeight(.semibold)
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
        .frame(height: 290)
    }
}

struct UpcomingGameRow_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingGameRow(categoryName: "Nearby Games", items: Game.sampleGames)
    }
}
