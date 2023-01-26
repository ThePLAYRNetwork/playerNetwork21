//
//  DayCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 12/6/22.
//

import SwiftUI

struct DayCell: View {
    @Binding var time: SessionTime
    let isLast: Bool
    var addTime: () -> Void
    
    var body: some View {
        HStack {
            DatePicker(
                "Start Date",
                selection: $time.start,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            
            Text("-")
            
            DatePicker(
                "End Date",
                selection: $time.end,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            
            if isLast {
                Button(action: { addTime() }) {
                    Image(systemName: "plus")
                        .font(.system(size: 9))
                        .foregroundColor(Color.ui.gray959595)
                }
            }
        }
        
    }
}

struct DayCell_Previews: PreviewProvider {
    static var previews: some View {
        DayCell(
            time: .constant(TrainingSessionCollection.sampleSession.data[0].times[0]),
            isLast: true,
            addTime: {}
        )
        .border(.blue)
    }
}
