//
//  PlayersYouMayKnowRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/13/22.
//

import SwiftUI

struct PlayersYouMayKnowRow: View {
    var body: some View {
        VStack {
            HStack {
                Text("Players You May Know")
                    .fontWeight(.semibold)
                Spacer()
                Button(action: {}) {
                    Text("Hide")
                        .font(.system(size: 12))
                        .fontWeight(.medium)
                }
            }
            .padding(.horizontal, 20)


            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 10) {
                    ForEach(User.sampleUsers, id: \.id) { user in
                        PlayersYouMayKnowItem(user: user)
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .padding(.top)
    }
}

struct PlayersYouMayKnowRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayersYouMayKnowRow()
            .border(.orange)
    }
}
