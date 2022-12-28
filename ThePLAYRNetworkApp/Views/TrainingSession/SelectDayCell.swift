//
//  SelectDayCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/27/22.
//

import SwiftUI

struct SelectDayCell: View {
    @State var isSelected = false
    @State var isShowingSheet = false
    @Binding var session: TrainingSession
    
    var body: some View {
        VStack {
            HStack {
                Toggle("Indoor", isOn: $isSelected)
                    .labelsHidden()
                    .tint(Color.ui.secondary)
                
                Text(session.day.rawValue.capitalized)
                    .font(.system(size: 16))
                    .padding(.leading)
                
                Spacer()
                
                Button(action: {
                    isShowingSheet.toggle()
                }) {
                    Text(session.times.count > 0 ? session.times[0].formattedSessionTime() : "Unavailable")
                        .foregroundColor(session.times.count > 0 ? Color.ui.times : Color.ui.subheading_text)
                        .padding(.horizontal, session.times.count > 0 ? 8 : 14)
                        .padding(.vertical, 3)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.ui.time_input)
                        }
                }
            }
            .padding(.top, 13)
            
            Divider()
        }
        .sheet(isPresented: $isShowingSheet) {
            DayOverlay(session: $session)
                .presentationDetents([.medium])
        }
    }
}

struct SelectDayCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectDayCell(session: .constant(TrainingSessionCollection.sampleSession.data[0]))
            .border(.blue)
    }
}
