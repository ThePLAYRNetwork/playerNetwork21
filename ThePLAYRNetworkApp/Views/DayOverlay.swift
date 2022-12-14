//
//  DayOverlay.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/27/22.
//

import SwiftUI

struct DayOverlay: View {
    @State var date: Date = Date()
    @State var isShowingRepeatOptionSheet = false
    @Binding var session: TrainingSession
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(session.day.rawValue.capitalized)
                .padding(.bottom, 7)
            
            Text(date.formatted(date: .long, time: .omitted))
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 20)
            
            Divider()
            
            HStack(spacing: 80) {
                Text("Start".uppercased())
                    .font(.system(size: 12))
                
                Text("End".uppercased())
                    .font(.system(size: 12))
            }
            .padding(.top, 15)
            
            // empty case
            if session.times.count == 0 {
                Button(action: {
                    let newTime = SessionTime(start: Date(), end: Date())
                    session.times.append(newTime)
                }) {
                    Text("Click to add time.")
                }
            }
            
            ForEach(Array($session.times.enumerated()), id: \.offset) { index, $time in
                DayCell(time: $time, isLast: index == session.times.count - 1) {
                    let newTime = SessionTime(start: Date(), end: Date())
                    session.times.append(newTime)
                }
                .padding(.bottom, 10)

            }
            
            Divider()
                .padding(.top, 10)
            
            
            Button(action: {
                isShowingRepeatOptionSheet.toggle()
            }) {
                Label(session.repeatOption.rawValue, image: "repeat")
            }
            .buttonStyle(.plain)
            .padding(.top, 24)
            
            Spacer()
            Button("Save", action: {})
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .padding(.top) // extra padding because sheet looks funny
        .sheet(isPresented: $isShowingRepeatOptionSheet) {
            RepeatOverlay(selectedOption: $session.repeatOption, isShowingSheet: $isShowingRepeatOptionSheet)
                .presentationDetents([.medium])
        }
    }
}

struct DayOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DayOverlay(session: .constant(TrainingSessionCollection.sampleSession.data[0]))
    }
}
