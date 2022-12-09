//
//  ClientProfileTopView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/8/22.
//

import SwiftUI

struct ClientProfileTopView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Circle()
                    .frame(width:115, height: 115)
                    .foregroundColor(Color.ui.light_gray)
                
                
                
                VStack(alignment: .leading) {
                    Text("Alex Allens")
                        .font(.system(size: 24,weight: .bold))
                    Text("**Highest Level:** College")
                        .font(.system(size: 16))
                    Text("**Plays Like:** Chris Paul")
                        .font(.system(size: 16))
                }
                
            }
            
            
            
            HStack {
              
                VStack{
                    Text("6’1”")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Height")
                        .font(.system(size: 12))
                }
                
                Spacer()
                VStack{
                    Text("195 lbs")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Weight")
                        .font(.system(size: 12))
                }
                Spacer()
                
                VStack{
                    Text("Point Guard")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Position")
                        .font(.system(size: 12))
                }
          
                
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 10)
            
            
            
            HStack {
                HStack(spacing: -4) {
                    ForEach(0..<3) { i in
                        
                        Circle()
                            .frame(width: 33, height: 33)
                            .foregroundColor(Color("light_gray"))
                            .overlay {
                                Circle().stroke(.white)
                            }
                    }
                    
                }
                .padding(.trailing,5)
                
                
                
                Text("Connected with ").font(.system(size: 12))  + Text("Tim, Charles")   .font(.system(size: 12, weight: .semibold)) + Text(", and ")   .font(.system(size: 12)) + Text("10 more").font(.system(size: 12, weight: .semibold))
                 
                
            }
       
            
        }
        .padding(.horizontal)
    }
}

struct ClientProfileTopView_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfileTopView()
    }
}
