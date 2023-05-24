//
//  HomeView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var locationManager: LocationManager
    @State var expandList: Bool = true
    @State var yDragTranslation: CGFloat = 0
    
    let session: Session
    var sessions: [Session]

    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                MapView()
                    .ignoresSafeArea(edges: Edge.Set.top)
                HomeSheetView(session: session, sessions: sessions)
                    .shadow(radius: 1)
                TopBar()
            }
        }
        .alert(isPresented: $homeViewModel.showingGamePosted) {
            Alert(
                title: Text("All right!"),
                message: Text("Your game has been posted."),
                dismissButton: Alert.Button.cancel()
            )
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear() {
            // Ask user for permission to use location
            locationManager.requestLocation()
        }
        // userLocation is initallly null, changes when user accepts permission or moves
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
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            HomeView()
//                .environmentObject(HomeViewModel(gameRepository: GameRepository()))
//                .environmentObject(LocationManager())
//        }
//    }
//}
