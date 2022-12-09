//
//  ClientProfile.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/7/22.
//

import SwiftUI

struct ClientProfile: View {
    
    var body: some View {
        ScrollView {
            VStack {
                ClientProfileTopView()
                VStack(alignment: .leading) {
                    HStack{
                        Button {
                            
                        } label: {
                            Text("Connect")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .frame(width: 175, height: 33)
                                .background(Color.ui.primary)
                                .background(in: RoundedRectangle(cornerRadius: 5))
                        }
                        
                        
                        
                        Button {
                            
                            
                        } label: {
                            Text("Message")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .frame(width: 175, height: 33)
                                .background(.black)
                                .background(in: RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
                .padding(.horizontal, 20)
                Divider()
                ExpandableClientProfile()
                Spacer()
            }
        }
    }
}

struct ClientProfile_Previews: PreviewProvider {
    static var previews: some View {
        ClientProfile()
    }
}
