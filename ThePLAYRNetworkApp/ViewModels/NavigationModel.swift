//
//  NavigationModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/13/23.
//

import Foundation
import SwiftUI

class NavigationModel: ObservableObject {
    @Published var path = NavigationPath() // stack of views
    @Published var homePath = NavigationPath()
    @Published var tabSelection: ThePlayrNetworkDestination = .home
    @Published var showiCloudErrorAlert = false
    @Published var showGameCreatedSuccessAlert = false
    @Published var showSessionCreateSuccessAlert = false
}

// MARK: Destinations

enum OnboardingDestination: Hashable {
    case onboarding
    case profile
    case role
    case position
}

enum ThePlayrNetworkDestination: Hashable {
    case home
    case calendar
    case create
    case inbox
    case profile
}

enum GameDestination: Hashable {
    case confirmGame
   
}

enum SessionDestination: Hashable {
    case confirmSession
}




