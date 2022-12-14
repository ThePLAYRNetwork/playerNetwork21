//
//  RepeatOverlay.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/29/22.
//

import SwiftUI

enum RepeatOption: String, CaseIterable, Identifiable {
    case does_not_repeat = "Does not repeat"
    case every_day = "Every day"
    case every_week = "Every week"
    case bi_weekly = "Bi-weekly"
    case every_month = "Every month"
    
    var id: Self { self }
}

struct RepeatOverlay: View {
    @Binding var selectedOption: RepeatOption
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            Button(action: { isShowingSheet.toggle()}) {
                Label("Repeat", systemImage: "arrow.left")
                    .font(.system(size: 20, weight: .semibold))
            }
            .buttonStyle(.plain)
            
            VStack(spacing: 25) {
                ForEach(RepeatOption.allCases) { option in
                    RepeatCell(selectedOption: $selectedOption, option: option)
                }
            }
            
            Spacer()
        }
        .padding()
        .padding(.top)

    }
}

struct RepeatOverlay_Previews: PreviewProvider {
    static var previews: some View {
        RepeatOverlay(selectedOption: .constant(.does_not_repeat), isShowingSheet: .constant(true))
    }
}
