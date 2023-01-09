//
//  DiscoverView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/19/22.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                DiscoverTopSection()
                EventsRow()
                
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
