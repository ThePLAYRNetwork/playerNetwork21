//
//  DiscoverView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/19/22.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var createGameViewModel: CreateGameViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel

    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var sessionViewModel: SessionViewModel
    @ObservedObject private var sessionRepo = SessionRepository()
        
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    DiscoverTopSection()
                    .padding(.bottom, 20)
                    
                    EventsRow()
                    
                }
                .onChange(of: locationManager.userLocation) { userLocation in
                    // User location exist (e.g. user accepts permission to user location)
                    if let userLocation = userLocation {
                        // Fetch data
                        Task {
                            await homeViewModel.fetchNearByGames(location: userLocation)
                        }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

//struct DiscoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoverView()
//    }
//}
