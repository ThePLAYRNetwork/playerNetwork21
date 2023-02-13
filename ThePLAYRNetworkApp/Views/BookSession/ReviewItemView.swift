//
//  ReviewItemView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/24/22.
//

import SwiftUI

struct ReviewItemView: View {
    var body: some View {
        
        HStack(alignment: .top) {
            Circle()
                .fill(.gray.opacity(0.4))
                .frame(width: 50, height: 50)
                .padding(.bottom)
                .padding(.horizontal,5)
            
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Charles Do")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                HStack {
                    ForEach(0...3, id: \.self) { star in
                        Image(systemName: "star.fill")
                            .frame(width: 11, height: 11)
                            .foregroundColor(Color.ui.accent)
                            .padding(.all, 1)
                        
                    }
                    
                    Image(systemName: "star.fill")
                        .frame(width: 13, height: 13)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.all, 1)
                    
                }
                .padding(.horizontal, 5)
                .padding(.bottom, 5)
                
                Text("Lorem ipsum dolor sit amet, consectetur a Ut enim ad minim veniam, quis nostrud exercitation ullamco.")
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 16))
            }
            
        }
        
        
    }
}

struct ReviewItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewItemView()
    }
}
