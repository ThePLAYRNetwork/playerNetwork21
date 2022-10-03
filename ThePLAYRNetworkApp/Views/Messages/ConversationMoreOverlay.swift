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
                    Text("Mute")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("mark_as_unread")
                    Text("Mark as unread")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("archive")
                    Text("Archive")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("report")
                    Text("Report or Block")
                }
                
                HStack(alignment: .center, spacing: 20) {
                    Image("delete_convo")
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
        ConversationMoreOverlay()
    }
}
