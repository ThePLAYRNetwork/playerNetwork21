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
            BackButton()
            
            HStack{
                SearchBar(text: $viewModel.searchText)
                    .padding(.vertical)

                ZStack(alignment: .topTrailing) {
                
                    Image("msg")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Circle()
                        .frame(width: 11, height: 11)
                        .foregroundColor(.white)
                        .offset(x: +5, y: -5)
                      
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.red)
                        .offset(x: +5, y: -5)
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
