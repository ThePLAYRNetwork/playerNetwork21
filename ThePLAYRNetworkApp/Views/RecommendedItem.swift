//
//  RecommendedItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/22/22.
//

import SwiftUI

struct RecommendedItem: View {
    var body: some View {
        ZStack(alignment: .bottom){
            // VStack(spacing: 0) {
            HStack{
                Image("powerLifting")
                    .resizable()
                    .opacity(0.65)
                    .frame(width: 252, height: 170)
            }
            
            // White
            
            HStack(spacing:5){
                Text("Powerlifting")
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.black)
                
                Text("with")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                
                Text("Christopher Jones")
                    .font(.system(size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
            }
            .padding(.horizontal)
            .frame(width:252, height: 35)
            .background(.white)
            
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .shadow(radius: 3)
        .fixedSize()
        .padding(.bottom)
    }
}

struct RecommendedItem_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedItem()
    }
}
