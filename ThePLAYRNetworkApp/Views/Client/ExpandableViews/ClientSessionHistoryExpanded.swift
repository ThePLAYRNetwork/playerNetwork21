//
//  ClientSessionHistoryExpanded.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 12/8/22.
//

import SwiftUI

struct ClientSessionHistoryExpanded: View {
    var body: some View {
        VStack(spacing: -15) {
            ForEach(0..<1, id: \.self) { history in
                SessionHistoryItem()
            }
        }
    }
}

struct ClientSessionHistoryExpanded_Previews: PreviewProvider {
    static var previews: some View {
        ClientSessionHistoryExpanded()
    }
}
