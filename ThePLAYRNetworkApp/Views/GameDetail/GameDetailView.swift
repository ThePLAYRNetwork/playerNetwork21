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
        ScrollView {
            VStack(spacing: 0) {
                Image("basketball")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.65)
                    .ignoresSafeArea()
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Group {
                            Text(game.title)
                                .bold()
                                .font(.system(size: 24))
                            Text("Wed \(game.startDate) at \(game.startTime) - \(game.endTime)")
                                .padding(.top, 2)
                                .font(.system(size: 16))
                            Text(game.location)
                                .padding(.top, 4)
                                .font(.system(size: 16))
                            
                            HStack(spacing: 4) {
                                Text("Organized by")
                                    .foregroundColor(.gray)
                                Text("Charles Do")
                            }
                            .font(.system(size: 12))
                            .padding(.top, 5)
                            
                            Text("Kevin & 12 others are going")
                                .font(.system(size: 12))
                                .padding(.top, 20)
                            HStack {
                                VStack(alignment: .leading) {
                                    PlayerAttendingCircles()
                                }
                                Text("SHOW")
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("red"))
                                Spacer()
                                Button(action: {}) {
                                   Text("Join Game")
                                        .bold()
                                }
                                .padding([.horizontal], 30)
                                .padding([.vertical], 7)
                                .foregroundColor(.white)
                                .background(Color("red"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .padding(.top, 8)
                        }
                        
                        Divider()
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                        
                        Text("Game Details").font(.system(size: 20)).bold()
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                            .padding(.top, 7)
                        Map(coordinateRegion: $region,
                            showsUserLocation: true,
                            userTrackingMode: $trackingMode,
                            annotationItems: [location]) { location in
                            MapMarker(coordinate: location.coordinate)
                        }
                            .cornerRadius(7)
                            .frame(height: 125)
                            .padding(.top, 22)

                            Spacer()
                    }
                    .padding()
                    .font(.system(size: 16))
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            self.region = MKCoordinateRegion(
                center: self.location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        }
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
