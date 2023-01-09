//
//  CalendarView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/15/22.
//

import SwiftUI

struct CalendarView: View {
    
    @State var currentDate: Date = Date()
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                
                CalendarTrainerView(interval: DateInterval(start: .distantPast, end: .distantFuture))
                 Divider()
                EventItem()
                EventItem()
                EventItem()
                

                
                
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
