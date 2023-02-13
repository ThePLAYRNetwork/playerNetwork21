//
//  JournalChartTabItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/6/22.
//

import SwiftUI

func didDismiss() {
    // Handle the dismissing action.
}

struct JournalChartTabItem: View {
    @ObservedObject var journalViewModel: JournalViewModel
    @State private var isShowingSheet = false

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DatePicker("Show shooting metric for date..", selection: $journalViewModel.date, displayedComponents: [.date])
                    .datePickerStyle(.compact)
                    .fixedSize()
                    .labelsHidden()
                
                Spacer()
                
                Button(action: {
                    isShowingSheet.toggle()
                }) {
                    Text("Input Data")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 10)
                        .background(Capsule().fill(Color.ui.accentColor))
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $isShowingSheet,
                       onDismiss: didDismiss) {
                    InputDataView(journalViewModel: journalViewModel)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }
            
            JournalChartView(journalViewModel: journalViewModel) // could use environment

            HStack {
                Menu {
                    Picker(selection: $journalViewModel.selectedCourtSection) {
                        ForEach(CourtSection.allCases) { value in
                            Text(value.rawValue) // use associated string
                                .tag(value)
                                .font(.largeTitle)
                        }
                    } label: {}
                } label: {
                    HStack {
                        Text(journalViewModel.selectedCourtSection.rawValue)
                            .font(.system(size: 14, weight: .semibold))

                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 4)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 8)
                    .background(Capsule().fill(Color.ui.black))
                }

                Spacer()
                
            }
            .padding(.bottom, 8)
            
            JournalCustomSegmentedControl(
                selectedIndex: $journalViewModel.selectedDateType,
                options: ["W", "M", "Y"],
                spacing: 16.0
            )
            .font(.system(size: 12))
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.ui.grayF6F6F6)
        }
    }
}

struct JournalChartTabItem_Previews: PreviewProvider {
    static var previews: some View {
        JournalChartTabItem(journalViewModel: JournalViewModel())
    }
}

