//
//  ReviewsView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/24/22.
//

import SwiftUI

struct ReviewsView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                //Nearby
                Text("Reviews")
                    .font(.title2)
                    .fontWeight(.bold)
                
                HStack {
                    Text("4.6")
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.black)
                    
                    Text("30+")
                }
                
                
                ForEach(0...4, id: \.self) { review in
                    ReviewItemView()
                    
                }
                
                
            }
            .padding()
        }
    }
}

struct ReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewsView()
    }
}
