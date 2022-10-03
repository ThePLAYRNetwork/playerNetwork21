//
//  DiscoverFilterItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/18/22.
//

import SwiftUI

struct DiscoverFilterItem: View {
    var filter: String
    var body: some View {
        Button(action: {}) {
            Text(filter)
            Image(systemName: "chevron.down")
        }
        .font(.system(size: 12))
        .foregroundColor(.gray)
        .buttonStyle(.plain)
        .padding(.vertical, 5)
        .padding(.horizontal, 14)
        .background {
            RoundedRectangle(cornerRadius: 100)
                .stroke(.gray, lineWidth: 1)
        }
    }
}

struct DiscoverFilterItem_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverFilterItem(filter: "Sort By")
    }
}
