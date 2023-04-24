//
//  CreatePlayerProfile19.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/13/22.
//

import SwiftUI

struct CreatePlayerProfile18: View {
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var ckUserViewModel: CloudKitUserViewModel
    @EnvironmentObject var onboardingViewModel: OnboardingViewModel

    var body: some View {
        VStack {
            CreatePlayerHeader()
                .ignoresSafeArea()
                .padding(.bottom, -75)
        
            ScrollView {
                VStack {
                    VStack(alignment: .leading) {
                        Text("SELECT YOUR ROLE")
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.horizontal)

                        HStack {
                            
                            Button {
                                onboardingViewModel.newUser.role = .player
                            } label: {
                                
                                VStack {
                                    Spacer()
                                    Image("player")
                                        .resizable()
                                        .frame(width:105, height: 75)
                                    
                                    
                                    Spacer()
                                    Text("Player")
                                        .font(.system(size: 16))
                                        .foregroundColor(ckUserViewModel.user.role == .player ? Color.ui.accentColor : Color.ui.gray959595)
                                        .padding(.top)
                                    Spacer()
                                }
                                .frame(width: 122, height: 157)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(ckUserViewModel.user.role == .player ? Color.ui.accentColor : Color.ui.grayC6C6C6)
                                )
                                
                                .overlay(
                                    ckUserViewModel.user.role == .player ? Color.clear : Color.ui.grayC6C6C6.opacity(0.4)
                                )
                            }

                            Button {
                                onboardingViewModel.newUser.role = .coach
                            } label: {
                                VStack {
                                    Spacer()
                                    Image("coach")
                                        .resizable()
                                        .frame(width:103, height: 95)
                                    
                                    Spacer()
                                    Text("Coach")
                                        .font(.system(size: 16))
                                        .foregroundColor(ckUserViewModel.user.role == .coach ? Color.ui.accentColor : Color.ui.gray959595)
                                    Spacer()
                                }
                                .frame(width: 122, height: 157)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(ckUserViewModel.user.role == .coach ? Color.ui.accentColor : Color.ui.grayC6C6C6)
                                )
                                
                                .overlay(
                                    ckUserViewModel.user.role == .coach ? Color.clear : Color.ui.grayC6C6C6.opacity(0.4)
                                    
                                )
                            }

                            Button {
                                onboardingViewModel.newUser.role = .trainer
                            } label: {
                                VStack {
                                    Spacer()
                                    Image("trainer")
                                        .resizable()
                                        .frame(width: 85, height: 96)
                                    
                                    Spacer()
                                    Text("Trainer")
                                        .font(.system(size: 16))
                                        .foregroundColor(ckUserViewModel.user.role == .trainer ? Color.ui.accentColor : Color.ui.gray959595)
                                    Spacer()
                                }
                                .frame(width: 122, height: 157)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(ckUserViewModel.user.role == .trainer ? Color.ui.accentColor : Color.ui.grayC6C6C6)
                                )
                                
                                .overlay(
                                    ckUserViewModel.user.role == .trainer ? Color.clear : Color.ui.grayC6C6C6.opacity(0.4)
                                )
                            }
                            
                        }
                        
                        .padding(.horizontal)
                        .padding(.bottom, 15)
                        
                        PlayerProfileOptions(colleges: onboardingViewModel.colleges)
                            .padding(.bottom, 50)
                        
                        
                        
                        Spacer()
                        
                    }
            
                    
                    Button {
                        navigationModel.path.append(OnboardingDestination.position)
                    } label: {
                        Text("Continue")
                            .foregroundColor(.white)
                            .frame(width:226, height: 48)
                            .background(Color.ui.accentColor)
                            .cornerRadius(34)
                            .padding(.bottom, 45)
                    }
                    .disabled(isDisabled())
                    .opacity(isDisabled() ? 0.5 : 1.0)
                }
            }
        }
        .onAppear {
            Task {
                await onboardingViewModel.fetchCollegeData()
            }
        }
    }
    
    private func isDisabled() -> Bool {
        return onboardingViewModel.newUser.height.isEmpty || onboardingViewModel.newUser.age == 0 || onboardingViewModel.newUser.school.isEmpty
    }
}

struct CreatePlayerProfile18_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayerProfile18()
            .environmentObject(NavigationModel())
            .environmentObject(CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()))
            .environmentObject(OnboardingViewModel(ckUserViewModel: CloudKitUserViewModel(userRepository: UserRepository(), navigationModel: NavigationModel()), userRepository: UserRepository(), navigationModel: NavigationModel()))
    }
}

