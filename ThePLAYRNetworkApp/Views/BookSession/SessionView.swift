//
//  SessionView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/14/22.
//

import SwiftUI

struct SessionView: View {
    @State var session: Session
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            
            VStack(alignment: .leading, spacing: 0) {
                Image("powerLifting")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: 402,height: 240)
                    .opacity(0.6)
                    .padding(.bottom)
                
                
                
                
                
                SessionInfo(session: Session(sessionTitle: ""))
                
                ScrollView {
                    Text("Description of session from the coach. Could include info like: personal words and advertising of the session, what customers will get out of the session, any equipment they need to bring, cancellation policies, etc.")
                        .font(.system(size: 14))
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.vertical)
                    
                    ReviewsView()
                        .padding(.horizontal, 11)
                }
                
                
                
                VStack {
                    Divider()
                    BookTrainingButton(price: 50)
                }
                .background(.white)
                .frame(height: 50)
            }
        }
    }
}

//struct SessionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionView(session: <#Session#>)
//    }
//}

struct BookTrainingButton: View {
    @State var price = 0
    var body: some View {
        
        
        HStack {
            Text("$\(price)")
                .foregroundColor(.black)
                .padding(.leading, 40)
            
            Spacer()
            NavigationLink(destination: BookSessionDate(session: Session(sessionTitle: ""))) {
                Text("Book Training")
                    .foregroundColor(.white)
                    .frame(width:143, height:33)
                    .background(Color("AccentColor"))
                    .cornerRadius(5)
            }
            
            
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(.black)
                .foregroundColor(.white)
                .frame(width: 36, height: 33)
                .overlay(
                    Image("turn.up.right")
                        .resizable()
                        .frame(width: 20, height: 18.33)
                      
                )
            
        }
        .frame(height:72)
        .padding(.trailing, 40)
        .padding(.horizontal)
    }
}




struct SessionInfo: View {
    @State var session: Session
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Powerlifting")
                .font(.system(size: 24))
                .bold()
            HStack{
                Text("Mon-Wed")
                    .font(.system(size: 16))
                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(.black)
                Text("1 hour")
                    .font(.system(size: 16))
                
                Circle()
                    .frame(width: 2, height: 2)
                    .foregroundColor(.black)
                
                Text("$\(session.sessionPrice)")
                    .font(.system(size: 16))
                
                
            }
            
            Text("Gym Name, San Diego")
                .font(.system(size: 16))
            
            HStack {
                Text("Taught by")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                
                Text("Christoper Jones")
                    .foregroundColor(.black)
                    .font(.system(size: 12))
            }
            .padding(.bottom, 8)
            
        }
        .padding(.horizontal)
        
    }
}
