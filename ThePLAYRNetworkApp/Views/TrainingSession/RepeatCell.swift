//
//  RepeatCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 11/29/22.
//

import SwiftUI

struct RepeatCell: View {
    @Binding var selectedOption: RepeatOption
    let option: RepeatOption
    
    var body: some View {
        Button(action: {
            selectedOption = option
        }) {
            HStack(spacing: 0) {
                Image("repeat")
                    .opacity(selectedOption == option ? 1 : 0)
                
                Text(option.rawValue)
                    .padding(.leading, 30)
                
                Spacer()
                
                Image("checkmark")
                    .opacity(selectedOption == option ? 1 : 0)
            }
        }
        .buttonStyle(.plain)
    }
}

struct RepeatCell_Previews: PreviewProvider {
    static var previews: some View {
        RepeatCell(selectedOption: .constant(.does_not_repeat), option: .does_not_repeat)
    }
}
