//
//  TrainingView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/18/22.
//

import SwiftUI

struct TrainingView: View {
    // @EnvironmentObject var trainingViewModel: TrainingViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var searchText: String = ""
    
    
    let session: Session
    var body: some View {
        ScrollView {
            HStack {
                SearchBar(text: $searchText)
                
                NavigationLink("Trainer Hub") {
                    TrainerHubView(session: session)
                }
                .font(.system(size: 14))
                .buttonStyle(CustomButton(color: .red, size: .small))
            }
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                //Nearby
                Text("Nearby Sessions")
                    .font(.title)
                    .fontWeight(.bold)
                

                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0 ... 2, id: \.self) { item in
                            NavigationLink {
                                SessionView(session: Session.sampleSessions[0])
                            } label: {
                                NearbySessionsItem()
                            }
                        }
                    }
                }

                
                //Recommended
                Text("Recommended by Friends")
                    .font(.title)
                    .fontWeight(.bold)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0 ... 2, id: \.self) { item in
                            NavigationLink {
                                SessionView(session: Session.sampleSessions[0])
                            } label: {
                                RecommendedItem()
                            }
                        }
                    }
                }
                
                //Specialist
                Text("Specialist")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                HStack {

                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color.ui.accentColor)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            VStack {
                                Image("ball")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding(.top, 10)
                                   
                                
                                VStack(alignment: .leading) {
                                    Text("Skills")
                                        .foregroundColor(Color.ui.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .offset(x: -15)
                                }
                            }
                        )

                    
                    NavigationLink {
                        SpecialistView()
                    } label: {
                        RoundedRectangle(cornerRadius: 4)
                            .aspectRatio(1.0, contentMode: .fit)
                            .overlay(
                                VStack {
                                    Image("ball")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .padding(.top, 10)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Skills")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16, weight: .bold))
                                            .offset(x: -15)
                                    }
                                }
                            )
                    }

                    
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color.ui.accentColor)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            VStack {
                                Image("cone")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding(.top, 10)
                                
                                VStack(alignment: .leading) {
                                    Text("Agility")
                                        .foregroundColor(Color.ui.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .offset(x: -15)
                                }
                            }
                        )
                    
                    
                    
                    
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color.ui.accentColor)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            VStack {
                                Image("weight")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding(.top, 10)
                                
                                VStack(alignment: .leading) {
                                    Text("Weight")
                                        .foregroundColor(Color.ui.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .offset(x: -10)
                                }
                            }
                        )
                    
                    
                    
                    RoundedRectangle(cornerRadius: 4)
                        .foregroundColor(Color.ui.accentColor)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            VStack {
                                Image("allInOne")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding(.top, 10)
                                
                                VStack(alignment: .leading) {
                                    Text("All in One")
                                        .foregroundColor(Color.ui.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .offset(x: -3)
                                }
                            }
                        )
                    
                    
                }
                .foregroundColor(Color.primary)
                
                
                //Triners
                Text("Triners")
                    .font(.title)
                    .fontWeight(.bold)
                
                
                
                HStack {
                    NavigationLink {
                        TrainersView()
                    } label: {
                        RoundedRectangle(cornerRadius: 4)
                            .aspectRatio(1.0, contentMode: .fit)
                            .overlay(
                                GeometryReader { geometry in
                                    Image("joseph")
                                        .resizable()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .clipShape(RoundedRectangle(cornerRadius: 4))
                                        .opacity(0.6)
                                    
                                    
                                } .overlay(
                                    Text("Joseph")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .offset(x: -10, y: +30)
                                )
                            )

                    }
                    .buttonStyle(.plain)

                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            GeometryReader { geometry in
                                Image("ty")
                                    .resizable()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .opacity(0.6)
                            } .overlay(
                                Text("Ty")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                                    .offset(x: -30, y: +30)
                            )
                        )
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            GeometryReader { geometry in
                                Image("christopher")
                                    .resizable()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .opacity(0.6)
                            } .overlay(
                                Text("Christopher")
                                    .foregroundColor(.white)
                                    .font(.system(size: 12, weight: .bold))
                                    .offset(x: -5, y: +30)
                            )
                        )
                    
                    RoundedRectangle(cornerRadius: 4)
                        .aspectRatio(1.0, contentMode: .fit)
                        .overlay(
                            GeometryReader { geometry in
                                Image("jacob")
                                    .resizable()
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .opacity(0.6)
                            } .overlay(
                                Text("Jacob")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                                    .offset(x: -10, y: +30)
                            )
                        )
                    
                    
                }
                
             
                
            }
            .padding(.horizontal)
            
        }        
    }
}
//
//struct TrainingView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainingView().preferredColorScheme(.dark)
//       // TrainingView()
//    }
//}
