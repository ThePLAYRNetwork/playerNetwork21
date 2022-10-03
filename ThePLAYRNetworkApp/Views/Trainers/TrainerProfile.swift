//
//  TrainerProfile.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/3/22.
//

import SwiftUI

struct TrainerProfile: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Image("christopherJones")
                    .resizable()
                    .frame(width: 96, height: 96)
      
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text("Christopher Jones")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
             
                    
                    
                    Text("Professional Trainer")
                        .font(.system(size: 16))
                    Text("San Diego, CA")
                        .font(.system(size: 16))
                    
                    
                    HStack (spacing: 5) {
                        Button {
                            
                        } label: {
                            Text("Strength")
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .frame(width: 60, height: 18)
                                .background(Color("lighter_gray"))
                                .cornerRadius(5)
                            
                        }
                        
                        
                        
                        Button {
                            
                        } label: {
                            Text("Weight")
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .frame(width: 60, height: 18)
                                .background(Color("lighter_gray"))
                                .cornerRadius(5)
                            
                            
                        }
                        
                        
                    }
                    
                }
                .padding(.horizontal, 5)
            }
            
            
            Text("Personal biography from trainer here. Can include experiences, qualitifications (certfications or bachelor’s), and any special pricing or deals they have.")
                .font(.system(size: 16))
            
        }
        
    }
}

struct TrainerProfile_Previews: PreviewProvider {
    static var previews: some View {
        TrainerProfile()
    }
}
