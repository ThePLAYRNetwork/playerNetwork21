//
//  SuggestedRow.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 9/22/22.
//

import SwiftUI

struct SuggestedRow: View {
    var body: some View {
        ScrollView(.vertical) {
            ForEach( 0...9, id: \.self) { suggestedItem in
                SuggestedItem()
            }
        }
        
    }
}

struct SuggestedRow_Previews: PreviewProvider {
    static var previews: some View {
        SuggestedRow()
    }
}
