//
//  ThePlayrNetworkView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/15/23.
//

// Bug: navigating to messages adds extra padding to top of all screens
import SwiftUI

struct ThePlayrNetworkView: View {
    @EnvironmentObject var navigationModel: NavigationModel

    var body: some View {
        TabView(selection: $navigationModel.tabSelection) {
            NavigationStack(path: $navigationModel.homePath) {
                HomeView()
                    .navigationDestination(for: SessionDestination.self) { destination in
                        switch destination {
                            
                        case .confirmSession:
                            ConfirmSessionView()
                        }
                    }
                    .navigationDestination(for: PostDestination.self) { destination in
                        switch destination {
                        case .networkFeed:
                            NetworkView()
                        case .createPost:
                            CreatePostView()
                        }
                    }
            }
            .tabItem {
                Image("home")
            }
            .tag(ThePlayrNetworkDestination.home)
            
            NavigationStack(path: $navigationModel.path) {
                CalendarView()
                    .background(Color.ui.whiteBg)
            }
            .tabItem {
                Image("ReCalendar")
            }
            .tag(ThePlayrNetworkDestination.calendar)
            
            NavigationStack(path: $navigationModel.gamePath) {
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

            NavigationStack(path: $navigationModel.path) {
                MessagesView()
                    .background(Color.ui.whiteBg)
            }
            .tabItem {
                Image("ReMsg")
            }
            .tag(ThePlayrNetworkDestination.inbox)

            NavigationStack(path: $navigationModel.path) {
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
            .environmentObject(NavigationModel())
            .environmentObject(HomeViewModel(gameRepository: GameRepository()))
            .environmentObject(CreateGameViewModel(gameRepository: GameRepository(), navigationModel: NavigationModel()))
            .environmentObject(SessionViewModel(sessionRepository: SessionRepository(), navigationModel: NavigationModel()))
    }
}
