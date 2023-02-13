//
//  MessagesView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/20/22.
//

import SwiftUI

struct MessagesView: View {
    @State var text: String = ""
    @State var showNewMessage = false
    
    var body: some View {
        ScrollView {
        VStack {
            HStack {
                
                ZStack(alignment: .trailing) {
                    SearchBar(text: $text)
                    
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .rotationEffect(.degrees(180))
                        .frame(width: 30, height:30)
                        .padding()
                        .foregroundColor(.gray)
                      
                }

                Image(systemName: "ellipsis.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.gray)
                    
                Button {
                    showNewMessage.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)
                }
      
                    
               
            }
            .padding(.horizontal)
            .padding(.bottom)
            
            MessageRow()
              
            
        }
        
        .navigationBarTitle("")
        .navigationBarHidden(false)
        
        .sheet(isPresented: $showNewMessage) {
            NewMessageView()
        }
        }
       
    }
    
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
