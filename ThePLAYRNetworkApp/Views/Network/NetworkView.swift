//
//  NetworkView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/4/22.
//

import SwiftUI

struct NetworkView: View {
    @State var posts = Post.samplePosts
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                TopSearchBarSection()
                divider
                
                PlayersYouMayKnowRow()
                                
                ForEach($posts, id: \.id) { $post in
                    PostItem(post: $post)
                    divider
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}

extension NetworkView {
    private var divider: some View {
        Rectangle()
            .frame(height: 7)
            .foregroundColor(Color.ui.lighter_gray)
    }
}
