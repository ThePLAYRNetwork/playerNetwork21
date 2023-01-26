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
        VStack(spacing: 0) {
            TopSearchBarSection()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    HStack{
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray.opacity(0.3))
                        
                        
                        Text("What's on your mind?")
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal)
                    
                    divider
                        .padding(.top, 30)
                    
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
}

struct NetworkView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkView()
    }
}

var divider: some View {
    Rectangle()
        .frame(height: 7)
        .foregroundColor(Color.ui.grayD9D9D9)
}
