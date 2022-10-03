//
//  MessageItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/20/22.
//

import SwiftUI





struct MessageItem: View {

    
    var body: some View {
        
        VStack {
            HStack(alignment: .top) {
                Circle()
                    .fill(Color.ui.light_gray)
                    .frame(width: 46, height: 46)
                   .padding(.trailing, 5)
                    .padding(.leading, 15)
                
                VStack(alignment: .leading){
                    HStack {
                        Text("Jared Mills")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Spacer()
                        Text("12:25 PM")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))

                        
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 6, height: 10)
                            .foregroundColor(.gray)
                         //   .padding(.trailing)

                            
                        
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, -3)
                    
                    
             
                    Text("Lorem ipsum dolor sit amet, consectetur dipicing elit, sed do eiusmod tempor lact saitld...")
                        .font(.system(size: 14))
                         .multilineTextAlignment(.leading)
                        .foregroundColor(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                 
                    Divider()

                }
  
            }
            .padding(.leading)

        }
        
    }
}

struct MessageItem_Previews: PreviewProvider {
    var user: User
    static var previews: some View {
        MessageItem()
    }
}
