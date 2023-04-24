//
//  OnboardingView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/13/22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @State var showGetStartedView = true
    @State var selection = 0
    
    let tabData = [
        OnboardingItem(
            poster: Image("onboarding_1"),
            title: "You got next".uppercased(),
            description: "Search for and create runs"
        ),
        OnboardingItem(
            poster: Image("onboarding_2"),
            title: "Sharpen Your Skills".uppercased(),
            description: "with videos, tips, and classes"
        ),
        OnboardingItem(
            poster: Image("onboarding_3"),
            title: "Get Connected".uppercased(),
            description: "Expand your basketball network"
        ),
        OnboardingItem(
            poster: Image("onboarding_4"),
            title: "Make Money".uppercased(),
            description: "by training other players"
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                Image("logo_large")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100)

                
                HStack {
                    Spacer()
                    
                    NavigationLink {
                        CreatePlayerProfileView()
                    } label: {
                        Text("Skip")
                            .foregroundColor(.secondary)
                            .underline()
                            .padding(.top)
                    }
                }
                
            }
            
            TabView(selection: $selection) {
                ForEach(tabData.indices) { index in
                    OnboardingTabItem(data: tabData[index])
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            Spacer()
            
            Button {
                if selection == 3 {
                    navigationModel.path.append(OnboardingDestination.profile)
                } else {
                    selection += 1
                }
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 46)
                    .background {
                        RoundedRectangle(cornerRadius: 34)
                            .fill(Color.ui.accentColor)
                    }
            }
            .buttonStyle(.plain)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .environmentObject(NavigationModel())
    }
}

struct OnboardingItem: Identifiable {
    var id = UUID()
    var poster: Image
    var title: String
    var description: String
}

struct OnboardingTabItem: View {
    let data: OnboardingItem
    
    var body: some View {
        VStack(spacing: 0) {
            data.poster
                .resizable()
                .scaledToFit()
                .padding(.bottom, 33)
            
            Text(data.title)
                .font(.system(size: 24, weight: .semibold))
            
            Text(data.description)
                .font(.system(size: 18))
                .foregroundColor(.secondary) // change color
        }
    }
}
