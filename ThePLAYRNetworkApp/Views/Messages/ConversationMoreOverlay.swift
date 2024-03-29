//
//  ConversationMoreOverlay.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/25/22.
//

import SwiftUI

struct ConversationMoreOverlay: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack(alignment: .center, spacing: 20) {
                    Image("mute")
                        .resizable()
                        .frame(width: 22.85, height: 17.25)
                    Text("Mute")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("mark_as_unread")
                        .resizable()
                        .frame(width: 23, height: 23)

                    Text("Mark as unread")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("archive")
                        .resizable()
                        .frame(width: 23, height: 21.85)
                    Text("Archive")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("report")
                        .resizable()
                        .frame(width: 23, height: 23)
                    
                    Text("Report or Block")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("delete_convo")
                        .resizable()
                        .frame(width: 17, height: 19)
                    
                    Text("Delete conversation")
                }
                
                Spacer()
                
            }
       //     .fontWeight(.medium)
            .padding(25)
        //    .padding(.top)
            
            Spacer()
        }
    }
}

struct ConversationMoreOverlay_Previews: PreviewProvider {
    static var previews: some View {
     //  ConversationMoreOverlay()
        ConversationMoreOverlay().preferredColorScheme(.dark)
    }
}
