//
//  InputDataColumn.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/8/22.
//

import SwiftUI
import CloudKit

struct InputDataColumn: View {
    @EnvironmentObject var journalViewModel: JournalViewModel
    @Binding var newJournal: Journal
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    Text("")
                        .frame(width: geometry.size.width * 0.50, alignment: .leading)
//                        .border(.orange)

                    Spacer()
                    
                    Text("Scored")
                        .frame(width: geometry.size.width * 0.20)
//                        .border(.orange)
                    
                    Spacer()
                    
                    Text("Attempts")
                        .frame(width: geometry.size.width * 0.25)
                        .lineLimit(1)
//                        .border(.orange)
                }
                .foregroundColor(.white)
                .fontWeight(.medium)
                
                ScrollView {
                    VStack(spacing: 0) {
                        // TOP
                        InputDataCell(
                            section: .leftCorner,
                            score: $newJournal.leftCornerScore,
                            attempt: $newJournal.leftCornerAttempt,
                            geometry: geometry)
                        
                        InputDataCell(
                            section: .leftShortCorner,
                            score: $newJournal.leftShortCornerScore,
                            attempt: $newJournal.leftShortCornerAttempt,
                            geometry: geometry)
                        
                        InputDataCell(
                            section: .paint,
                            score: $newJournal.paintScore,
                            attempt: $newJournal.paintAttempt,
                            geometry: geometry)
                        
                        InputDataCell(
                            section: .rightShortCorner,
                            score: $newJournal.rightShortCornerScore,
                            attempt: $newJournal.rightShortCornerAttempt,
                            geometry: geometry)
                        
                        InputDataCell(
                            section: .rightCorner,
                            score: $newJournal.rightCornerScore,
                            attempt: $newJournal.rightCornerAttempt,
                            geometry: geometry)
                    }
                }

            }
            .background(Color.ui.black)
        }
    }
}

struct InputDataColumn_Previews: PreviewProvider {
    static var previews: some View {
        InputDataColumn(newJournal: .constant(Journal.sampleJournal))
            .environmentObject(JournalViewModel())
    }
}
