//
//  MessageRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/20/22.
//

import SwiftUI

struct MessageRow: View {
    var messages = [Message]()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
          
                ForEach(0...8, id: \ .self) { message in
                    
                    NavigationLink(destination: ConversationView()) {
                        MessageItem()
                    }
                    
                }
   
            }
        }
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow()
    }
}



