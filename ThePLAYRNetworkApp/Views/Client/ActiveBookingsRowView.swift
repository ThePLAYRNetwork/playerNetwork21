//
//  ActiveBookingsRowView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/29/22.
//

import SwiftUI

struct ActiveBookingsRowView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0...4, id: \.self) { activeBooking in
                    ActiveBookingsItemView()
                        .listRowInsets(EdgeInsets())
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)

    }
}

struct ActiveBookingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveBookingsRowView()
    }
}
