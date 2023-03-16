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
}
