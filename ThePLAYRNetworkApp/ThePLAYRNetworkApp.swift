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
    @State var selectedDay: Int = 4
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
                            MessagesView()
                        }
                        .tabItem { Label("Message", systemImage: "message") }.tag(Tab.inbox)
                        
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
        let secondary = Color("secondary")
        
        // grays
        let cards = Color("cards")
        let input_field_bg = Color("input_field_bg")
        let messages_bg = Color("messages_bg")
        let suggestions_bg = Color("suggestions_bg")
        let background_gray = Color("backgroundGray")

        
        let tags = Color("tags")
        let divider_lines = Color("divider_lines")
        let time_input = Color("time_input")
        let star_reviews = Color("star_reviews")
        
        let subheading_text = Color("subheading_text")
        let search_bar = Color("search_bar")
        
        let selector_bg = Color("selector_bg")
        
        let overlay_bg = Color("overlay_bg")
        
        // red
        let signifies = Color("signifies")
        let interactable = Color("interactable")
        let elements = Color("elements")
        
        // purple
        let accent = Color("accent")
        
        // black
        let buttons = Color("buttons")
        let icons = Color("icons")
        
        // blue
        let links = Color("links")
        let times = Color("times")
        
        // orange
        let calendar_cards = Color("calendar_cards")
        
        // green
        let online_symbol = Color("online_symbol")
        let calendar_icon = Color("calendar_icon")
        let chart_up_arrow = Color("chart_up_arrow")
        
        // other
        let posted_article_title = Color("posted_article_title")
        let court_color_red = Color("court_color_red")
        let court_color_green = Color("court_color_green")
        let court_color_yellow = Color("court_color_yellow")
        let scroll_wheel = Color("scroll_wheel")
        let facebook_bg = Color("facebook_bg")
        
        // delete later?
        let light_gray = Color("light_gray")
        let lighter_gray = Color("lighter_gray")
        let button_gray_background = Color("button_gray_background")
        let placeholders = Color("placeholders")
        let card_gray = Color("card_gray")
        


        let heat_red = Color("heat_red")
        let heat_yellow = Color("heat_yellow")
        let heat_green = Color("heat_green")
        let green = Color("green")
        let court_selected = Color("court_selected")
        let journal_card = Color("journal_card")
        let attempt_line = Color("attempt_line")
        let journal_picker_bg = Color("journal_picker_bg")
        let button_black = Color("button_black")
    }
}
