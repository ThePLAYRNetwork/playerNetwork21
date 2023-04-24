//
//  ThePlayrNetworkView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/15/23.
//

import SwiftUI

struct ThePlayrNetworkView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        TabView(selection: $navigationModel.tabSelection) {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image("home")
            }
            .tag(ThePlayrNetworkDestination.home)
            
            NavigationView{
                CalendarView()
                    .background(Color.ui.whiteBg)
            }
            .tabItem {
                Image("ReCalendar")
            }
            .tag(ThePlayrNetworkDestination.calendar)
            
            NavigationStack(path: $navigationModel.path) {
                CreateGameView()
                    .navigationDestination(for: GameDestination.self) { destination in
                        switch destination {
                        case .confirmGame:
                            ConfirmGameView()
                        }
                    }
            }
            .padding(.top, 20)
            .tabItem {
                Image("RePlus")
            }
            .tag(ThePlayrNetworkDestination.create)

            NavigationView {
                MessagesView()
                    .background(Color.ui.whiteBg)
            }
            .tabItem {
                Image("ReMsg")
            }
            .tag(ThePlayrNetworkDestination.inbox)

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image("profile")
            }
            .tag(ThePlayrNetworkDestination.profile)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ThePlayrNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        ThePlayrNetworkView()
            .environmentObject(HomeViewModel(gameRepository: GameRepository(), sessionRepository: SessionRepository()))
            .environmentObject(CreateGameViewModel(gameRepository: GameRepository(), navigationModel: NavigationModel()))
            .environmentObject(SessionViewModel(sessionRepository: SessionRepository(), navigationModel: NavigationModel()))
    }
}
