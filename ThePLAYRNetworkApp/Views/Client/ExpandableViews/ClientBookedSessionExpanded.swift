//
//  ClientBookedSessionExpanded.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/8/22.
//

import SwiftUI

struct ClientBookedSessionExpanded: View {
    var body: some View {
        VStack(alignment: .leading){
        
            VStack(alignment: .leading){

                HStack {
                    Text("Defense Training")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    
                    Text("$50")
                        .font(.system(size: 16))
                        .foregroundColor(Color.ui.accentColor)
                }
                VStack(alignment: .leading,spacing: -5){
                    HStack {
                        Text("Tuesday, August 2")
                            .font(.system(size: 12))
                        Text(".")
                            .font(.title)
                            .bold()
                            .offset(y: -7)
                        
                        Text("10:00am - 11:00am")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.black)
                    
              
                        Text("Gym Name, San Diego")
                        .font(.system(size: 12))
                            .foregroundColor(.black)
     
                    
                }
                
                
                
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Cancel Session")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(width: 148, height: 33)
                            .background(Color.ui.accentColor)
                            .background(in: RoundedRectangle(cornerRadius: 10))
                        
                }
                    .padding(.trailing, 0)
                }

            }
            .padding()
            .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.ui.grayF6F6F6)
                .shadow(color: Color.ui.grayD9D9D9, radius: 1, x: 0, y: 5)
            
        )
        }
        .padding()
    }
}

struct ClientBookedSessionExpanded_Previews: PreviewProvider {
    static var previews: some View {
        ClientBookedSessionExpanded()
    }
}
