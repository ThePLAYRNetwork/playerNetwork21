//
//  TopSearchBarSection.swift
//  ThePLAYRNetworkApp
//
//  Created by Mirna Helmy on 8/31/22.
//

import SwiftUI

struct TopSearchBarSection: View {
    @ObservedObject var viewModel = SearchViewModel()

    var body: some View {
        VStack(alignment: .leading){
           // BackButton()
            
            HStack{
                SearchBar(text: $viewModel.searchText)
                    .padding(.vertical)

                ZStack(alignment: .topTrailing) {
                
                    Image("msg")
                        .resizable()
                        .frame(width: 28.22, height: 25.08)

                }
            }
        }
        .padding()
    }
}

struct TopSearchBarSection_Previews: PreviewProvider {
    static var previews: some View {
        TopSearchBarSection()
    }
}
