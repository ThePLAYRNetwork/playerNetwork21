//
//  ThePLAYRNetworkApp.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI
import FirebaseCore


enum Tab {
    case home
    case calendar
    case create
    case inbox
    case profile
}

@main
struct ThePLAYRNetworkApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var homeViewModel = HomeViewModel()
    @StateObject private var createViewModel = CreateViewModel()
    @State private var selection: Tab = .home
    
    
    init() {
        FirebaseApp.configure()
    }
    @State private var text = ""
    
    var body: some Scene {
        WindowGroup {
            Group {
                // If user is loggedin, show main app, else show login screen
                if authViewModel.isLoggedIn {
                    TabView(selection: $authViewModel.selection) {
                        NavigationView {
                            HomeView()
                                .onAppear() {
                                    // Ask user for permission to use location
                                    homeViewModel.checkIfLocationServicesIsEnabled()
                                }
                        }
                        .tabItem { Label("Home", systemImage: "house") }.tag(Tab.home)
                        
                        NavigationView {
                            CalendarView()
                            
                        }
                        .tabItem { Label("Calendar", systemImage: "calendar.badge.clock") }.tag(Tab.calendar)
                        
                        NavigationView {
                            CreateGameView()
                                .environmentObject(createViewModel)
                        }
                        .tabItem { Label("Create a Game", systemImage: "plus.circle.fill") }.tag(Tab.create)
                        .onDisappear {
                            print("Calling onDisappear()")
                            createViewModel.game = Game() // reset user input
                        }
                        
                        
                        NavigationView {
                            NetworkView()
                        }
                        .tabItem { Label("Inbox", systemImage: "briefcase") }.tag(Tab.inbox)
                        
                        NavigationView {
                            ProfileView()
                        }
                        .tabItem { Label("Profile", systemImage: "person.crop.circle") }.tag(Tab.profile)
                    }
                } else {
                    NavigationView {
                        LoginView()
                    }
                }
            }
            
            .environmentObject(authViewModel)
            .environmentObject(homeViewModel)
        }
        
        
    }
}

extension Color {
    static let ui = Color.UI()
    
    struct UI {
        let primary = Color("red")
        let secondary = Color("secondary_purple")
        let light_gray = Color("light_gray")
        let lighter_gray = Color("lighter_gray")
        let button_gray_background = Color("button_gray_background")
        let text_placeholder = Color("text_placeholder")
        let card_gray = Color("card_gray")
        let subheading_text = Color("subheading_text")
        
        let heat_red = Color("heat_red")
        let heat_yellow = Color("heat_yellow")
        let heat_green = Color("heat_green")
        
        let court_selected = Color("court_selected")
        
        let journal_card = Color("journal_card")
        
        let attempt_line = Color("attempt_line")
        
        let journal_picker_bg = Color("journal_picker_bg")
        let button_black = Color("button_black")
    }
}
