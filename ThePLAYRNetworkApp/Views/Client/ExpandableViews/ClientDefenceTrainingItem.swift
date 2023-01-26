//
//  ClientDefenceTrainingItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/7/22.
//

import SwiftUI

struct ClientDefenceTrainingItem: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Image("exclam")
                    .resizable()
                    .frame(width: 17, height: 17)
                Text("Owes $50.00")
                    .font(.system(size: 12))
                    .padding(.trailing,4)
                    .foregroundColor(Color.ui.gray959595)
        
            }
            VStack(alignment: .leading){
                
                
                
                HStack {
                    Text("Defense Training")
                        .font(.system(size: 16, weight: .semibold))
                    Spacer()
                    
                    Text("$50")
                        .font(.system(size: 16))
                        .foregroundColor(Color.ui.primary)
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

struct ClientDefenceTrainingItem_Previews: PreviewProvider {
    static var previews: some View {
        ClientDefenceTrainingItem()
    }
}
