//
//  MapView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @State private var trackingMode = MapUserTrackingMode.follow
    
    var body: some View {
        Map(coordinateRegion: $homeViewModel.region,
            showsUserLocation: true,
            userTrackingMode: $trackingMode,
            annotationItems: homeViewModel.locations) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    // Note: Should fetch game data from CloudKit when clicking pin.
                    NavigationLink(destination: GameDetailView(game: Game(), location: location)) {
                            PinView()
                        }
                    }
                }
            .animation(.easeIn)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(HomeViewModel())
    }
}

struct PinView: View {
    var body: some View {
        Circle()
            .fill(.white)
            .frame(width: 30, height: 30)
            .shadow(radius: 2, x: 0, y: 3)
            .overlay {
                Image("pin")
                    .resizable()
                    .frame(width: 15, height: 20)
                    .aspectRatio(contentMode: .fill)
            }
//        Image("pin")
//            .resizable()
//            .frame(width: 15, height: 20)
//            .aspectRatio(contentMode: .fill)
//            .background {
//                Circle()
//                    .fill(.white)
//                    .frame(width: 30, height: 30)
//                    .shadow(radius: 2, x: 0, y: 3)
//            }
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView()
    }
}
