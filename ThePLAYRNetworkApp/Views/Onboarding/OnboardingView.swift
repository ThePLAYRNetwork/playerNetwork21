//
//  OnboardingView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/13/22.
//

import SwiftUI

struct OnboardingView: View {
    @State var showGetStartedView = true // set to true
    
    var body: some View {
        if showGetStartedView {
            VStack {
                Spacer()
                
                Image("logo_large")
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                Button {
                    showGetStartedView = false
                } label: {
                    Text("Get Started")
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
            
        } else {
            VStack(spacing: 0) {
                ZStack(alignment: .top) {
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            OnboardingSignupView()
                        } label: {
                            Text("Skip")
                                .foregroundColor(.secondary)
                                .underline()
                                .padding(.top)
                        }

                    }
                    
                    Image("logo_large")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 100)
                }
                
                TabView {
                    OnboardingTabItem(
                        poster: Image("onboarding_1"),
                        title: "You got next".uppercased(),
                        description: "Search for and create runs"
                    )
                    
                    OnboardingTabItem(
                        poster: Image("onboarding_2"),
                        title: "Sharpen Your Skills".uppercased(),
                        description: "with videos, tips, and classes"
                    )
                    
                    OnboardingTabItem(
                        poster: Image("onboarding_3"),
                        title: "Get Connected".uppercased(),
                        description: "Expand your basketball network"
                    )
                    
                    OnboardingTabItem(
                        poster: Image("onboarding_4"),
                        title: "Make Money".uppercased(),
                        description: "by training other players"
                    )
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                Spacer()
                
                Button {
                    showGetStartedView = false
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
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

struct OnboardingTabItem: View {
    let poster: Image
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 0) {
            poster
                .resizable()
                .scaledToFit()
                .padding(.bottom, 33)
            
            Text(title)
                .font(.system(size: 24, weight: .semibold))
            
            Text(description)
                .font(.system(size: 18))
                .foregroundColor(.secondary) // change color
        }
    }
}
