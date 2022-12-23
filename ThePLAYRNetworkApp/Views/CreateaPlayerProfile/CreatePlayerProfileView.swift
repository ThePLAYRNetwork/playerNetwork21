//
//  CreatePlayerProfileView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/13/22.
//
// ***** THIS VIEW IS NOT USED YET, AND MIGHT NOT BE
import SwiftUI

struct CreatePlayerProfileView: View {
    @State var firstName: String
    @State var lastName: String
    @State var email: String
    
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("onboardingLogo")
                        .resizable()
                        .frame(width: 83, height: 68)
                        
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 60)
                
                VStack(alignment: .center) {
                    Circle()
                        .foregroundColor(Color.ui.light_gray)
                        .frame(width: 120, height: 120)
                    
                    Text("Choose a Profile Photo")
                        .font(.system(size: 12))
                        .foregroundColor(Color.ui.light_gray)
                }
                .padding(.bottom)
                
            }
            .frame(height: 281)
            .background(Color.ui.button_black)
            .clipShape(RoundedShape(corners: [.bottomRight]))
            .clipShape(RoundedShape(corners: [.bottomLeft]))

            
            
            HStack{
                VStack(alignment: .leading){
                    Text("FIRST NAME")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField(
                        "John", text: $firstName
                    )
                    .padding()
                    .frame(width:184, height: 50)
                    .background(Color.ui.journal_card)
                    .cornerRadius(10)
                }
                
                
                VStack(alignment: .leading){
                    Text("LAST NAME")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.black)
                    
                    TextField(
                        "Doe", text: $lastName
                    )
                    .padding()
                    .frame(width:184, height: 50)
                    .background(Color.ui.journal_card)
                    .cornerRadius(10)
                }
                
            }
            .padding()
            
            
            
            VStack(alignment: .leading){
                Text("EMAIL")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.black)
                
                TextField(
                    "example@gmail.com", text: $email
                )
                .padding()
                .frame(width:378, height: 50)
                .background(Color.ui.journal_card)
                .cornerRadius(10)
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            NavigationLink(destination: CreatePlayerProfile16(phoneNumber: "", password: "", confirmPassword: "")) {
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

struct CreatePlayerProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayerProfileView(firstName: "", lastName: "", email: "")
    }
}
