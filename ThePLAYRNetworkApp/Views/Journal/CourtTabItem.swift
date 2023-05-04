//
//  CourtRegular.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 10/23/22.
//

import SwiftUI

struct CourtTabItem: View {
    // JournalView owns journalViewModel
    @EnvironmentObject var journalViewModel: JournalViewModel
    @State private var isShowingSheet = false
    let isHeatMap: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                DatePicker("Show shooting metric for date..",
                           selection: $journalViewModel.selectedDate,
                           displayedComponents: [.date]
                )
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
                    InputDataView()
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                }
//                       .disabled(journalViewModel.selectedDateRange != .day)
            }
            
            CourtView(isHeatMap: isHeatMap)
            
            HStack {
                Text("Ratio")
                    .font(.system(size: 12, weight: .semibold))
                    .fontWeight(.medium)
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(journalViewModel.selectedDisplay == 0 ? Color.ui.black : .clear))
                    .foregroundColor(journalViewModel.selectedDisplay == 0 ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                journalViewModel.selectedDisplay = 0
                            }
                    }
                    .background {
                        Capsule().fill(Color.ui.grayDADADA)
                    }
                
                Spacer()
                
                Text("Percent")
                    .font(.system(size: 12, weight: .semibold))
                    .padding(.vertical, 3)
                    .padding(.horizontal, 10)
                    .background(Capsule().fill(journalViewModel.selectedDisplay == 1 ? Color.ui.black : .clear))
                    .foregroundColor(journalViewModel.selectedDisplay == 1 ? .white : .red)
                    .onTapGesture {
                        withAnimation(.interactiveSpring(
                            response: 0.1, dampingFraction: 1.5, blendDuration: 0.5)) {
                                journalViewModel.selectedDisplay = 1
                            }
                    }
                    .background {
                        Capsule().fill(Color.ui.grayDADADA)
                    }
            }
            .padding(.bottom, 8)
            
            JournalCustomSegmentedControl(
                selectedDateRange: $journalViewModel.selectedDateRange,
                spacing: 15.0
            )
            
            //            CustomSegmentedControl(
            //                selectedIndex: $journalViewModel.selectedDateType,
            //                options: ["D", "W", "M", "Y"],
            //                spacing: 15.0
            //            )
            //            .font(.system(size: 12))
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 17)
                .fill(Color.ui.grayF6F6F6)
        }
    }
}

struct CourtTabItem_Previews: PreviewProvider {
    static var previews: some View {
        CourtTabItem(isHeatMap: false)
            .environmentObject(JournalViewModel(journalRepository: JournalRepository()))
    }
}
