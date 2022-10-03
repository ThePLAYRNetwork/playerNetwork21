//
//  SheetButtonRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/27/22.
//

import SwiftUI

struct SheetButtonRow: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 4)
                .aspectRatio(1.0, contentMode: .fit)
            RoundedRectangle(cornerRadius: 4)
                .aspectRatio(1.0, contentMode: .fit)
            RoundedRectangle(cornerRadius: 4)
                .aspectRatio(1.0, contentMode: .fit)
            RoundedRectangle(cornerRadius: 4)
                .aspectRatio(1.0, contentMode: .fit)
        }
        .foregroundColor(Color.ui.primary)
    }
}

struct SheetButtonRow_Previews: PreviewProvider {
    static var previews: some View {
        SheetButtonRow()
    }
}
