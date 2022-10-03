//
//  SuggestedItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/22/22.
//

import SwiftUI

struct SuggestedItem: View {
    var body: some View {
    
            HStack {
                Circle()
                    .fill(Color.ui.light_gray)
                    .frame(width: 46, height: 46)

                    .padding(.trailing, 5)
                
                VStack(alignment: .leading){
                        Text("Jared Mills")
                            .foregroundColor(.black)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
              
                    
                    Text("Point Guard @school, San Diego")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    
                    Divider()
                        
                
                }
                Spacer()
            }
          .padding(.leading)

    }
}

struct SuggestedItem_Previews: PreviewProvider {
    static var previews: some View {
        SuggestedItem()
    }
}
