//
//  CalendarView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 1/9/23.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                
                CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                Divider()
                ForEach(0..<5) { _ in
                    EventItem()
                }

                
                Spacer()
            }
            
            .padding(.horizontal)
            
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
