//
//  TopBar.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 7/29/22.
//

import SwiftUI

struct TopBar: View {
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Button(action: {}) {
                    Image("logo")
                        .resizable()
                        .frame(width: 60, height: 60)
                }
                Spacer()
                HStack {
                    Image("pin")
                        .resizable()
                        .frame(width: 12, height: 16)
                    Text("UC San Diego")
                        .font(.system(size: 12))
                        .fontWeight(.semibold)
                }
            }
            .padding([.leading, .trailing])
            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.10) // match (70)
            .background(Color.ui.whiteBg)
        }
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar()
            .previewLayout(.sizeThatFits)
    }
}
