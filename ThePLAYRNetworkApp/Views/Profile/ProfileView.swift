//
//  ProfileView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 8/3/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    var body: some View {
        Button(action: { authViewModel.signOut() }) {
            Text("Sign out")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
