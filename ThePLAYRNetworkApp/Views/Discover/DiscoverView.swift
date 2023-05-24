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
    
    let sessions = [Session]()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    DiscoverTopSection()
                    .padding(.bottom, 20)
                    
                    EventsRow()
                    
                    List(sessionViewModel.sessions, id: \.recordID) { session in
                        Text(session.title)
                    }
                    
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
//
//                .task {
//                    do {
//                       try await sessionViewModel.fetchSession()
//
//                        print("yes")
//                    } catch {
//                        print("no")
//
//                    }
//                }
//
//                .onAppear {
//                  let session = Session()
//                    Task {
//                    //    try await sessionRepo.getSession()
//                        try await sessionViewModel.addSession(session: session)
//                    }
//                }
                
//
//                .onChange(of: locationManager.userLocation) { userLocation in
//                    // User location exist (e.g. user accepts permission to user location)
//                    if let userLocation = userLocation {
//                        // Fetch data
//                        Task {
//                            await sessionRepo.fetchSession(location: userLocation)
//                        }
//                    }
//                }
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
