//
//  AvailabilityView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/23/22.
//

import SwiftUI

struct AvailabilityView: View {
    @State var currentDate2: Date = Date()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Availability")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
            DatePicker(currentDate2: $currentDate2)
            
        }
        .padding(.horizontal)
    }
}

struct AvailabilityView_Previews: PreviewProvider {
    static var previews: some View {
        AvailabilityView()
    }
}
