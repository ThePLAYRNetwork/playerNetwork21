//
//  PlayerItemView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/29/22.
//

import SwiftUI

struct PlayerItemView: View {
    
    var body: some View {
     
            HStack(spacing: 0) {
                ZStack(alignment: .topTrailing){
                    Circle()
                        .strokeBorder(Color.ui.primary, lineWidth: 2)
                        .background(Circle().fill(Color.ui.light_gray))
                        .frame(width:46, height:46)
                        
                    Circle()
                        .frame(width:12, height:12)
                        .foregroundColor(Color.ui.primary)
                    
                    
                    
                }
                
                VStack(alignment: .leading, spacing: 1){
                    HStack{
                        Image("client").resizable()
                            .frame(width: 16, height: 16)
                           
                        Text("Alex Allens")
                            .font(.system(size: 16))
                            .padding(.trailing,4)
                
                    }
                    
                    Text("Upcoming Session 7/12/22")
                        .font(.system(size: 12))
                    
                    HStack{
                        Image("exclam")
                            .resizable()
                            .frame(width: 10, height: 10)
                        Text("Owes $50.00")
                            .font(.system(size: 12))
                            .padding(.trailing,4)
                
                    }
                    
                }
                .padding()
                
                
                Spacer()
                
                Image("bubbleText")
                    .resizable()
                    .frame(width: 20.1, height: 20.07)
            }
            .padding(.horizontal)
            .padding(.vertical, -5)
     
    }
}

struct PlayerItemView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerItemView()
    }
}
