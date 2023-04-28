//
//  ThePLAYRNetworkApp.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI
import CloudKit
//import Firebase

enum Tab {
    case home
    case calendar
    case create
    case inbox
    case profile
}

// TODO: Schedule, refresh button on home page
@main
struct ThePLAYRNetworkApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject private var ckUserViewModel: CloudKitUserViewModel
    @StateObject private var homeViewModel: HomeViewModel
    @StateObject private var createViewModel: CreateGameViewModel
    @StateObject private var sessionViewModel: SessionViewModel
    @StateObject private var navigationModel = NavigationModel()
    @StateObject private var onboardingViewModel: OnboardingViewModel
    @StateObject private var locationManager = LocationManager.shared
    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var coverImageViewModel = CoverImageViewModel()
    
    @StateObject private var journalViewModel = JournalViewModel()

    init() {
        let gameRepository = GameRepository()
        let sessionRepository = SessionRepository()
        let userRepository = UserRepository()
        let navigationModel = NavigationModel()
        let ckUserViewModel = CloudKitUserViewModel(userRepository: userRepository, navigationModel: navigationModel)
        self._homeViewModel = StateObject(wrappedValue: HomeViewModel(gameRepository: gameRepository))
        self._ckUserViewModel = StateObject(wrappedValue: ckUserViewModel)
        self._navigationModel = StateObject(wrappedValue: navigationModel)
        self._onboardingViewModel = StateObject(wrappedValue: OnboardingViewModel(ckUserViewModel: ckUserViewModel, userRepository: userRepository, navigationModel: navigationModel))
        self._createViewModel = StateObject(wrappedValue: CreateGameViewModel(gameRepository: gameRepository, navigationModel: navigationModel))
        self._calendarViewModel = StateObject(wrappedValue: CalendarViewModel(gameRepository: gameRepository))
        self._sessionViewModel = StateObject(wrappedValue: SessionViewModel(sessionRepository: sessionRepository, navigationModel: navigationModel))
        
        // carousel dot color
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.ui.grayECECEC)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationModel.path) {
                Group { // use for conditional
                    // Use full modal
                    if ckUserViewModel.showOnboarding {
                        GetStartedView()
                    } else {
                        ThePlayrNetworkView()
                    }
                }
                .navigationDestination(for: OnboardingDestination.self) { destination in
                    switch destination {
                    case .onboarding:
                        OnboardingView()
                    case .profile:
                        CreatePlayerProfileView()
                    case .role:
                        CreatePlayerProfile18()
                    case .position:
                        OnboardingPosition()
                    }
                }
                .navigationDestination(for: ThePlayrNetworkDestination.self) { _ in
                    ThePlayrNetworkView()
                }
                .navigationDestination(for: GameDestination.self) { destination in
                    switch destination {
                    case .confirmGame:
                        ConfirmGameView()
                    }
                }
                // note: can only use 1 alert, use enums and switch to show different alert
                .alert(isPresented : $navigationModel.showiCloudErrorAlert) {
                    Alert(
                        title: Text("Sign in to iCloud"),
                        message: Text("To use all features of our app, you must be logged into iCloud. Please log in to iCloud in your device settings to continue using our app.")
                    )
                }
//                .alert(isPresented : $navigationModel.showGameCreatedSuccessAlert) {
//                    Alert(
//                        title: Text("Alright!"),
//                        message: Text("Your game has been posted.")
//                    )
//                }
            }
            // Don't put all viewmodels on top heiracrchy
            .environmentObject(navigationModel)
            .environmentObject(ckUserViewModel)
            .environmentObject(homeViewModel)
            .environmentObject(createViewModel)
            .environmentObject(sessionViewModel)
            .environmentObject(onboardingViewModel)
            .environmentObject(locationManager)
            .environmentObject(calendarViewModel)
            .environmentObject(coverImageViewModel)
            .environmentObject(journalViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
        return true
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
