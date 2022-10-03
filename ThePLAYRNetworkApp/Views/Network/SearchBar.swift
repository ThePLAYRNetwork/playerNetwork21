//
//  SearchBar.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/31/22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack{
            TextField("Search", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .overlay(
                    HStack{
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth:.infinity, alignment: .leading)
                            .padding(.leading,8)
                    }
                )
        }
        .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(.gray, lineWidth: 1)
        )
  
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
