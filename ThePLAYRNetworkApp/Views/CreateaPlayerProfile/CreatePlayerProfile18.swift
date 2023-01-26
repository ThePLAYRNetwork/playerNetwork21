//
//  CreatePlayerProfile19.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/13/22.
//

import SwiftUI

struct CreatePlayerProfile18: View {
    @State var selectedCard: Int = 1
    
    
    var body: some View {
        VStack {
            createPlayerHeader()
                .ignoresSafeArea()
                .padding(.bottom, -55)
            
            ScrollView {
                VStack {
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("SELECT YOUR ROLE")
                            .font(.system(size: 12, weight: .semibold))
                            .padding(.top, 30)
                            .padding(.leading, -190)
                        
                    }
                    
                    
                    HStack {
                        
                        Button {
                            selectedCard = 1
                        } label: {
                            
                            VStack {
                                Spacer()
                                Image("player")
                                    .resizable()
                                    .frame(width:105, height: 75)
                                
                                
                                Spacer()
                                Text("Player")
                                    .font(.system(size: 16))
                                    .foregroundColor(selectedCard == 1 ? Color.ui.primary : Color.ui.gray959595)
                                    .padding(.top)
                                Spacer()
                            }
                            .frame(width: 122, height: 157)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(selectedCard == 1 ? Color.ui.primary : Color.black)
                            )
                            
                            .overlay(
                                selectedCard == 1 ? Color.clear : Color.ui.grayC6C6C6
                                
                            )
                        }
                        
                        
                        
                        //  Spacer()
                        Button {
                            selectedCard = 2
                        } label: {
                            VStack {
                                Spacer()
                                Image("coach")
                                    .resizable()
                                    .frame(width:103, height: 95)
                                
                                Spacer()
                                Text("Coach")
                                    .font(.system(size: 16))
                                    .foregroundColor(selectedCard == 2 ? Color.ui.primary : Color.ui.gray959595)
                                Spacer()
                            }
                            .frame(width: 122, height: 157)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(selectedCard == 2 ? Color.ui.primary : Color.black)
                            )
                            
                            .overlay(
                                selectedCard == 2 ? Color.clear : Color.ui.grayC6C6C6
                                
                            )
                        }
                        
                        // Spacer()
                        Button {
                            selectedCard = 3
                        } label: {
                            VStack {
                                Spacer()
                                Image("trainer")
                                    .resizable()
                                    .frame(width: 85, height: 96)
                                
                                Spacer()
                                Text("Trainer")
                                    .font(.system(size: 16))
                                    .foregroundColor(selectedCard == 3 ? Color.ui.primary : Color.ui.gray959595)
                                Spacer()
                            }
                            .frame(width: 122, height: 157)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(selectedCard == 3 ? Color.ui.primary : Color.black)
                            )
                            
                            .overlay(
                                selectedCard == 3 ? Color.clear : Color.ui.grayC6C6C6
                                
                            )
                        }
                        
                    }
                    
                    .padding(.horizontal)
                    .padding(.bottom, 15)
                    
                    PlayerProfileOptions()
                        .padding(.bottom, 50)
                    
                    Spacer()
                    
                    
                    NavigationLink(destination:
                                    //change this destination
                                   CreatePlayerProfile16(phoneNumber: "", password: "", confirmPassword: "")
                    ) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .frame(width:226, height: 48)
                            .background(Color.ui.primary)
                            .cornerRadius(34)
                            .padding(.top, 50)
                            .padding(.bottom, 45)
                    }
                }
            }
        }
    }
}

//struct CreatePlayerProfile18_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatePlayerProfile18()
//    }
//}
