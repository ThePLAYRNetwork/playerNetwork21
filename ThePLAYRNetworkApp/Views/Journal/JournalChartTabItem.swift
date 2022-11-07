//
//  JournalChartTabItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/6/22.
//

import SwiftUI

struct JournalChartTabItem: View {
    @ObservedObject var journalViewModel: JournalViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DatePicker("Show shooting metric for date..", selection: $journalViewModel.date, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .fixedSize()
                    .labelsHidden()
                
                Spacer()
                
                Button(action: {}) {
                    Text("Input Data")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background(Capsule().fill(Color.ui.primary))
                }
                .buttonStyle(.plain)
            }
            
            JournalChartView()

            HStack {
                Button(action: {}) {
                    HStack {
                        Text("Right Corner")
                            .font(.system(size: 14, weight: .semibold))

                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 4)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 8)
                    .background(Capsule().fill(Color.ui.button_black))
                }
                .buttonStyle(.plain)

                Spacer()
                
            }
            .padding(.bottom, 8)
            
            CustomSegmentedControl(
                selectedIndex: $journalViewModel.selectedDateType,
                options: ["W", "M", "Y"],
                spacing: 20.0
            )
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.ui.journal_card)
        }
    }
}

struct JournalChartTabItem_Previews: PreviewProvider {
    static var previews: some View {
        JournalChartTabItem(journalViewModel: JournalViewModel())
    }
}

