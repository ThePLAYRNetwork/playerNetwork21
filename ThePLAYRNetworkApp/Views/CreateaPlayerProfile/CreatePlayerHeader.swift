//
//  CreatePlayerHeader.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 3/21/23.
//

import SwiftUI

struct CreatePlayerHeader: View {
    
    
    var body: some View {
        
        HStack {
            Image("onboardingLogo")
                .resizable()
                .frame(width:83, height: 68)
                .padding(.top, 45)
            Spacer()
            Circle()
                .foregroundColor(Color.ui.grayD9D9D9)
                .frame(width: 36, height: 36)
                .padding(.top, 45)
        }
        .padding(.top, 45)
        .padding(.horizontal)
        .frame(height: 147)
        .background(Color.ui.black)
        .clipShape(RoundedShape(corners: [.bottomRight]))
        .clipShape(RoundedShape(corners: [.bottomLeft]))
    }
}



struct CreatePlayerHeader_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlayerHeader()
    }
}
