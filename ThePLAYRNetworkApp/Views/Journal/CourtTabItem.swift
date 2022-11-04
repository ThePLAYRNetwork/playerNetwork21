//
//  CourtRegular.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/23/22.
//

import SwiftUI

struct CourtTabItem: View {
    // JournalView owns journalViewModel
    @ObservedObject var journalViewModel: JournalViewModel
    let isHeatMap: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DatePicker(selection: $journalViewModel.date, displayedComponents: [.date]) {
                    Text(journalViewModel.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.system(size: 20, weight: .semibold))
                }
            }

            CourtView(journalViewModel: journalViewModel, isHeatMap: isHeatMap)

            HStack {
                CustomSegmentedControl(
                    selectedIndex: $journalViewModel.selectedDisplay,
                    options: ["Ratio", "Percent"],
                    spacing: 0.0
                )
                .font(.system(size: 12))

                Spacer()
                
                Button(action: {}) {
                    Text("Input Data")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(Capsule().fill(Color.ui.journal_black_bg))
                }
                .buttonStyle(.plain)
            }
            .padding(.bottom, 8)
            
            CustomSegmentedControl(
                selectedIndex: $journalViewModel.selectedDateType,
                options: ["D", "W", "M", "Y"],
                spacing: 30.0
            )
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.ui.journal_background)
        }
    }
}

struct CourtTabItem_Previews: PreviewProvider {
    static var previews: some View {
        CourtTabItem(journalViewModel: JournalViewModel(), isHeatMap: false)
    }
}
