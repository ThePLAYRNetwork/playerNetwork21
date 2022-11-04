//
//  CalendarTrainerView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/6/22.
//

import SwiftUI

struct CalendarTrainerView: UIViewRepresentable {
    let interval: DateInterval
    
    
    func makeUIView(context: Context) -> some UIView {
        let view = UICalendarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.fontDesign = .rounded
       // view.font = UIFont.systemFont(ofSize: 13)
         view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
    
        return view
    }
    
//    func calendarView(_ calendarView: UICalendarView) {
//        let font = UIFont.systemFont(ofSize: 10)
//
//    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
