//
//  DiscoverTopSection.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/13/22.
//

import SwiftUI

struct DiscoverTopSection: View {
    @State var text: String = ""
    var filters = ["Sort By", "Type", "Date", "Time", "Distance"]
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                    Spacer()
                }
                ZStack {
                    HStack {
                        Spacer()
                        HStack {
                            Image("pin")
                            Text("UC San Diego")
                                .font(.system(size: 12))
                                .fontWeight(.semibold)
                                .frame(alignment: .trailing)
                        }
                    }
                    HStack {
                        Text("Discover")
                            .font(.system(size: 24))
                            .bold()
                    }
                }
                .padding(.bottom, 14)
                
                SearchBar(text: $text)
            }
            .padding([.top, .horizontal])
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 8) {
                    ForEach(filters, id: \.self) { filter in
                        DiscoverFilterItem(filter: filter)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .padding(.horizontal)
                .padding(.vertical)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct DiscoverTopSection_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverTopSection()
            .previewLayout(.sizeThatFits)
            .frame(height: 250)
    }
}
