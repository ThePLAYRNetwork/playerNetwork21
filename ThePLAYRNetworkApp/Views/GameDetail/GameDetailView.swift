//
//  GameDetailView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//


import SwiftUI
import MapKit

// note: 10 views max per container -> use Group{}
struct GameDetailView: View {
    @State private var region = MKCoordinateRegion()
    @State var trackingMode = MapUserTrackingMode.follow
    let game: Game
    let location: Location
    
    var body: some View {
      //  NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    GameDetailBackground()
                    
                    GameDetailTopSection(game: game)
                        .padding(.top, 14)
                    
                    Divider()
                        .padding(.top, 14)
                    
                    GameDetailBottomSection(trackingMode: $trackingMode, region: $region, location: location)
                        .padding(.top, 4)
                    
                    Spacer()
                }
            }
            .background(Color.ui.whiteBg)
          //  .navigationBarBackButtonHidden(true)
            .edgesIgnoringSafeArea(.top)
            .onAppear {
                self.region = MKCoordinateRegion(
                    center: self.location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            }
   //    }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GameDetailView(game: Game.sampleGames[0], location: Location())
            //                .environmentObject(HomeViewModel()) // dunno why i need this, i dont use it in this view
        }
    }
}

struct GameDetailBackground: View {
    var body: some View {
        Image("basketball")
            .resizable()
            .opacity(0.65)
            .scaledToFit()
//            .overlay(alignment: .topLeading) {
//                BackButton()
//                    .padding()
//                    .padding(.top, 45)
//            }
        
    }
}

