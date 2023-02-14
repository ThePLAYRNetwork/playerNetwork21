//
//  ConversationView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/25/22.
//

import SwiftUI

struct ConversationView: View {
    @State private var showingOptions = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ConversationHeaderView(showingOptions: $showingOptions)
                
                ConversationColumnView()
                
                ConversationBottomView()
            }
            .sheet(isPresented: $showingOptions) {
                ConversationMoreOverlay()
                    .presentationDetents([.fraction(0.35)])
            }
          //  .navigationBarBackButtonHidden(true)
            
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
