//
//  ReviewsView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/24/22.
//

import SwiftUI

struct ReviewsView: View {
    var body: some View {
   
            VStack(alignment: .leading) {
                //Nearby
                Text("Reviews")
                    .font(.system(size: 20, weight: .semibold))
                
                
                HStack {
                    Text("4.6")
                        .font(.system(size: 16))
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    
                    Text("(30+)")
                        .font(.system(size: 16))
                }
                
                
                ForEach(0...4, id: \.self) { review in
                    ReviewItemView()
                    
                }
                
                
            }
            .padding(.horizontal, 4)
   
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
