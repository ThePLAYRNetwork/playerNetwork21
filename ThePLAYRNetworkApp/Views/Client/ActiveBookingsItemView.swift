//
//  ActiveBookingsItemView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/29/22.
//

import SwiftUI

struct ActiveBookingsItemView: View {
    @State var activeBooking = "Alex"
    var body: some View {
        VStack {
            Circle()
                .frame(width: 46, height: 46)
                .foregroundColor(Color.ui.grayD9D9D9)
            Text(activeBooking)
                .font(.system(size: 12))
                
        }
    }
}

struct ActiveBookingsItemView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveBookingsItemView()
    }
}
