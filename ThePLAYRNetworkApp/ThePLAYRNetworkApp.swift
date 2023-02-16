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
                            .tabItem {
                                // Label("", systemImage: "house")
                                Image("home")

                            }
                            .tag(Tab.home)


                            NavigationView{
                                CalendarView()
                                    .background(Color.ui.whiteBg)
                            }
                            .tabItem {
                                //Label("Calendar", systemImage: "calendar.badge.clock")
                                Image("ReCalendar")


                            }
                            .tag(Tab.calendar)




                            NavigationView {
                                CreateGameView()
                                    .environmentObject(createViewModel)
                            }
                            .padding(.top, 20)

                            .tabItem {
                                //  Label("Create a Game", systemImage: "plus.circle.fill")
                                Image("RePlus")
                            }
                            .tag(Tab.create)
                            .onDisappear {
                                print("Calling onDisappear()")
                                createViewModel.game = Game() // reset user input
                            }


                            NavigationView {
                                MessagesView()
                                    .background(Color.ui.whiteBg)
                            }
                            .tabItem {
                                // Label("Message", systemImage: "message")
                                Image("ReMsg")
                            }
                            .tag(Tab.inbox)

                            NavigationView {
                                ProfileView()
                            }
                            .tabItem {
                                // Label("Profile", systemImage: "person.crop.circle")
                                Image("profile")
                            }
                            .tag(Tab.profile)
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
        
        // red(primary)
        let accentColor = Color("AccentColor") // same like red, elements, interactable, signifies before
        
        // grays
        
        let grayF6F6F6 = Color("grayF6F6F6") //card, input field bg, messages bg, suggestions bg
        let grayECECEC = Color("grayECECEC")
        let gray959595 = Color("gray959595") //subheading text, search bar
        let grayDADADA = Color("grayDADADA")
        let grayC6C6C6 = Color("grayC6C6C6")
        let grayD9D9D9 = Color("grayD9D9D9")
        let grayGray = Color("grayGray") //small cirecles "PlayerAttendingCircles"
        
        
        // purple(accent)
        let accent = Color("accent") //same like purple, secondary before
        let accent_light = Color("accent").opacity(0.6) //same like court_selected
        let accent_lighter = Color("accent").opacity(0.1) // messages highlight
        
        
        // black
        let black = Color("black") // buttons, icons
        let black_light = Color("black").opacity(0.25) //opacity 25%, bg overlay on success notifications & trainer images
        let blackBlack = Color("blackBlack") //small circles
        let blackWhite = Color("blackWhite") //rating in profile view
        let blackExtraBlack = Color("blackExtraBlack") //some buttons in goingView
        
        
        
        // blue
        let blue = Color("blue") //links, times
        
        
        // orange
        let orange = Color("orange") //calendar cards
        let orange_light = Color("orange_light").opacity(0.7) //calendar cards (past)
        
        
        // green
        let green = Color("green") //online symbol, calendar icon (client), chart up arrow
        
        let posted_article_title = Color("posted_article_title")
        
        //court color
        let court_color_red = Color("court_color_red") //same like heat_red before
        let court_color_green = Color("court_color_green")
        let court_color_yellow = Color("court_color_yellow")
        
        
        let scroll_wheel = Color("scroll_wheel")

        //white
        let white = Color("white")
        let whiteBg = Color("white_bg")
        let whiteWhite = Color("whiteWhite")
        

    }
}
