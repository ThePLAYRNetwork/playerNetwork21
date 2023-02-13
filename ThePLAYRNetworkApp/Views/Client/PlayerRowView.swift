//
//  PlayerRowView.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 11/30/22.
//

import SwiftUI

struct PlayerRowView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("A")
                .font(.system(size: 16))
                .bold()
                .padding(.leading)
            Divider()
                .padding(.leading)
            
            ForEach(0..<3, id: \.self) { player in
                NavigationLink {
                    ClientProfile()
                } label: {
                    PlayerItemView()
                        .padding(.vertical, -2)
                }
                .buttonStyle(.plain)

            }
        }
    }
}

struct PlayerRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRowView()
    }
}
