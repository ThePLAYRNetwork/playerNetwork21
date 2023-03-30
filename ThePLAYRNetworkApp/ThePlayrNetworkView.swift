//
//  ThePlayrNetworkView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/15/23.
//

import SwiftUI

struct ThePlayrNetworkView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Image("home")
            }
            
            NavigationView{
                CalendarView()
                    .background(Color.ui.whiteBg)
            }
            .tabItem {
                Image("ReCalendar")
            }
            .tag(Tab.calendar)
            NavigationView {
                CreateGameView()
            }
            .padding(.top, 20)
            .tabItem {
                Image("RePlus")
            }
            .tag(Tab.create)

            NavigationView {
                MessagesView()
                    .background(Color.ui.whiteBg)
            }
            .tabItem {
                Image("ReMsg")
            }
            .tag(Tab.inbox)
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image("profile")
            }
            .tag(Tab.profile)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ThePlayrNetworkView_Previews: PreviewProvider {
    static var previews: some View {
        ThePlayrNetworkView()
            .environmentObject(HomeViewModel(gameRepository: GameRepository()))
            .environmentObject(CreateViewModel())
    }
}
