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
                
                ForEach(0...5, id: \.self) { event in
                    EventItem()
                        .padding(.horizontal)
                }
                padding()
                
                
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
