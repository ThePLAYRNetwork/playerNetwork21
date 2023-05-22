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
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        Map(coordinateRegion: $locationManager.region,
            showsUserLocation: true,
            userTrackingMode: $homeViewModel.trackingMode,
            annotationItems: homeViewModel.nearbyGames.map { $0.location.coordinate }) { coordinate in
                MapAnnotation(coordinate: coordinate) {
                    NavigationLink(destination: GameDetailView(game: Game.sampleGames[0])) {
                        PinView()
                    }
            }
        }
//            .onAppear {
////                locationManager.setRegionToUserPosition()
//            }
////            .animation(.easeIn)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(HomeViewModel(gameRepository: GameRepository()))
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
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView()
    }
}


