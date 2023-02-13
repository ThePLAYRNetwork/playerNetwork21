//
//  NewMessageView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/22/22.
//

import SwiftUI

struct NewMessageView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        VStack(alignment: .leading) {
            ZStack{
                Color.ui.grayD9D9D9
                
                HStack{
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(Color.ui.accentColor)
                            .font(.system(size: 14))
                         .padding(.trailing)
                    }
         
                    
                }
                HStack {
                    Text("New Message")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                }
                
                .padding(.bottom)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 50)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("To:")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 19, height: 19)
                        .foregroundColor(Color.ui.accentColor)
                    
                    
                }
                .padding(.top)
                .padding(.horizontal)
                Divider()
                Text("Suggested")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                
                    .padding()
                
                SuggestedRow()
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(false)
        
        
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView()
    }
}
