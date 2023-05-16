//
//  DiscoverView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/19/22.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject var createGameViewModel: CreateGameViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    DiscoverTopSection()
                   ConfirmSessionView()
                    ConfirmGameDetails(game: createGameViewModel.newGame)
                        .padding(.bottom, 20)
                    EventsRow()
                    
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
