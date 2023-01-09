//
//  BackButton.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/8/23.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // button takes primary color
        Button(action: { dismiss() }) {
            Image("back_arrow")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 21))
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
