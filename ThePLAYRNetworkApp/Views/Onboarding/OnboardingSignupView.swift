//
//  OnboardingSignupView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/13/22.
//

import SwiftUI
import AuthenticationServices

struct OnboardingSignupView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            Image("logo_large")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            VStack {
                Button(action: {}) {
                    Text("Continue with Facebook")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(RoundedRectangle(cornerRadius: 34).fill(Color.ui.blue))
                }
                .buttonStyle(.plain)
                
                SignInWithAppleButton(
                    onRequest: { request in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    },
                    onCompletion: { result in
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Code@*/ /*@END_MENU_TOKEN@*/
                    }
                )
                .frame(height: 48)
                .clipShape(RoundedRectangle(cornerRadius: 34))
                
                Button(action: {}) {
                    Text("Continue with Google")
                        .font(.system(size: 20, weight: .medium))
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .background(RoundedRectangle(cornerRadius: 34).fill(.white)) // background is clickable
                        .overlay {
                            RoundedRectangle(cornerRadius: 34)
                                .stroke(.black)
                            
                        }
                }
                .buttonStyle(.plain)

            }
            // nested vstack to make divider horizontal
            HStack {
                OnboardingDivider()
                
                Text("Or".uppercased())
                    .foregroundColor(Color.ui.gray959595)
                    .font(.system(size: 14))
                    .padding(.vertical, 15)

                OnboardingDivider()
            }
            
            Button(action: {}) {
                Text("Create Account")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .background(RoundedRectangle(cornerRadius: 34).fill(Color.ui.accentColor)) // background is clickable
            }
            .buttonStyle(.plain)
            
            // Can't really modify parts of text, hacky solution
            VStack {
                HStack(spacing: 0) {
                    Text("By signing up, I accept the ")
                    Text("Terms of use")
                        .foregroundColor(.blue)
                        .underline()
                    Text(" and")
                }
                Text("Private policy")
                    .foregroundColor(.blue)
                    .underline()
            }
            .font(.system(size: 12))
            .padding(.horizontal)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
            
            // This is better way but can't underline
//            Text("By signing up, I accept the [Terms of use](https://example.com) and [Private policy](https://example.com)")
//                .font(.system(size: 12))
//                .padding(.horizontal)
//                .multilineTextAlignment(.center)
//                .padding(.top, 10)
//                .tint(Color.ui.links)
            
            VStack {
                Text("Already have an account?")
                    .font(.system(size: 14))
                
                Button(action: {}) {
                    Text("Log in here".uppercased())
                        .foregroundColor(Color.ui.blue)
                }
            }
            .padding(.top, 50)
        }
        .padding()
        
    }
}

struct OnboardingSignupView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSignupView()
    }
}

struct OnboardingDivider: View {
    let thickness: CGFloat = 1
    
    var body: some View {
        Rectangle()
            .fill(Color.ui.gray959595)
            .frame(height: thickness)
            .edgesIgnoringSafeArea(.horizontal)
            .frame(width: 60)
    }
}
