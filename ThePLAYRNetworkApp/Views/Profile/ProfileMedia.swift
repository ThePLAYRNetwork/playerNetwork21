//
//  ProfileMedia.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 1/1/23.
//

import SwiftUI

struct ProfileMedia: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Media")
                .font(.system(size: 20, weight: .semibold))
                .padding(.leading)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    ForEach(1..<5) { _ in
                        Rectangle()
                            .fill(Color.ui.grayD9D9D9)
                            .frame(width: 126, height: 126)
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct ProfileMedia_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMedia()
    }
}
