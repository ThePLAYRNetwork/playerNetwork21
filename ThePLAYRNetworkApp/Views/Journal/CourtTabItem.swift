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
    @State private var isShowingSheet = false
    let isHeatMap: Bool
    
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
                        .background(Capsule().fill(Color.ui.primary))
                }
                .buttonStyle(.plain)
                .sheet(isPresented: $isShowingSheet,
                       onDismiss: didDismiss) {
                    InputDataView(journalViewModel: journalViewModel)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
            }

            CourtView(journalViewModel: journalViewModel, isHeatMap: isHeatMap)

            HStack {
                Text("Ratio")
                    .font(.system(size: 12, weight: .semibold))
                    .fontWeight(.medium)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(journalViewModel.selectedDisplay == 0 ? Color.ui.button_black : .clear))
                    .foregroundColor(journalViewModel.selectedDisplay == 0 ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                journalViewModel.selectedDisplay = 0
                            }
                    }
                    .background {
                        Capsule().fill(Color.ui.journal_picker_bg)
                    }

                Spacer()
                
                Text("Percent")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(journalViewModel.selectedDisplay == 1 ? Color.ui.button_black : .clear))
                    .foregroundColor(journalViewModel.selectedDisplay == 1 ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                journalViewModel.selectedDisplay = 1
                            }
                    }
                    .background {
                        Capsule().fill(Color.ui.journal_picker_bg)
                    }
            }
            .padding(.bottom, 8)
            
            CustomSegmentedControl(
                selectedIndex: $journalViewModel.selectedDateType,
                options: ["D", "W", "M", "Y"],
                spacing: 15.0
            )
            .font(.system(size: 12))

        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.ui.journal_card)
        }
    }
}

struct CourtTabItem_Previews: PreviewProvider {
    static var previews: some View {
        CourtTabItem(journalViewModel: JournalViewModel(), isHeatMap: false)
    }
}
