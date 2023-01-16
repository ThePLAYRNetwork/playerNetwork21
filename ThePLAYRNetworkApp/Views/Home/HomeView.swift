//
//  HomeView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var expandList: Bool = true
    @State var yDragTranslation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                MapView()
                    .ignoresSafeArea(edges: Edge.Set.top)
                HomeSheetView()
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
            homeViewModel.checkIfLocationServicesIsEnabled()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .environmentObject(AuthViewModel())
                .environmentObject(HomeViewModel())
        }
    }
}
