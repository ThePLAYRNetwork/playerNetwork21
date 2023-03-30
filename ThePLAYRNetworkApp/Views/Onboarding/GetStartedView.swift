//
//  GetStartedView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 3/16/23.
//

import SwiftUI

struct GetStartedView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel

    var body: some View {
        VStack {
            Spacer()
            
            Image("logo_large")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            NavigationLink(value: OnboardingDestination.onboarding) {
                Text("Get Started")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 46)
                    .background {
                        RoundedRectangle(cornerRadius: 34)
                            .fill(Color.ui.accentColor)
                    }
            }
        }
        .padding()
    }
}

struct GetStartedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            GetStartedView()
                .environmentObject(NavigationModel())
        }
    }
}
