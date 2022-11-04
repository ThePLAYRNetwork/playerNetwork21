//
//  SessionItemRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 10/10/22.
//

import SwiftUI

struct SessionItemRow: View {
    var body: some View {
        ScrollView(.vertical) {
            ForEach( 0...2, id: \.self) { session in
                VStack {
                    SessionItemTrainers()
                    CapsuleTime()
                }

                    .padding(.horizontal)
            }
        }
    }
}

struct SessionItemRow_Previews: PreviewProvider {
    static var previews: some View {
        SessionItemRow()
    }
}
