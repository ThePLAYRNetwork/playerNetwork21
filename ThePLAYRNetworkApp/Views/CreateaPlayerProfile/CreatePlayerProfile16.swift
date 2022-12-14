//
//  CreatePlayerProfile16.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/13/22.
// ***** THIS VIEW IS NOT USED YET, AND MIGHT NOT BE

import SwiftUI

struct CreatePlayerProfile16: View {
    @State var phoneNumber: String
    @State var password: String
    @State var confirmPassword: String
    
    var body: some View {
        VStack {
            
            createPlayerHeader()
            
            VStack(alignment: .leading){
                
                Text("PHONE NUMBER")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                TextField(
                    "(   )  -", text: $phoneNumber
                )
                .padding()
                .frame(height: 50)
                .background(Color.ui.journal_card)
                .cornerRadius(10)
                .padding(.bottom, 15)
                
                
                
                Text("PASSWORD")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                TextField(
                    "", text: $password
                )
                .padding()
                .frame(height: 50)
                .background(Color.ui.journal_card)
                .cornerRadius(10)
                .padding(.bottom, 15)
                
                
                
                Text("CONFIRM PASSWORD")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                TextField(
                    "", text: $phoneNumber
                )
                .padding()
                .frame(height: 50)
                .background(Color.ui.journal_card)
                .cornerRadius(10)
                
                
                
                
            }
            .padding(.horizontal, 3)
            .padding()
            Spacer()
            
            
            NavigationLink(destination: CreatePlayerProfile18() ) {
                Text("Continue")
                    .foregroundColor(.white)
                    .frame(width:226, height: 48)
                    .background(Color.ui.primary)
                    .cornerRadius(34)
                    .padding(.bottom, 45)
            }
        }
        .ignoresSafeArea()
    }
}

struct CreatePlayerProfile16_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayerProfile16(phoneNumber: "", password: "", confirmPassword: "")
    }
}



struct createPlayerHeader: View {
    
    
    var body: some View {
        
        HStack {
            Image("onboardingLogo")
                .resizable()
                .frame(width:83, height: 68)
            Spacer()
            Circle()
                .foregroundColor(Color.ui.light_gray)
                .frame(width: 36, height: 36)
        }
        .padding(.top, 45)
        .padding(.horizontal)
        .frame(height: 127)
        .background(Color.ui.button_black)
        .clipShape(RoundedShape(corners: [.bottomRight]))
        .clipShape(RoundedShape(corners: [.bottomLeft]))
    }
}


