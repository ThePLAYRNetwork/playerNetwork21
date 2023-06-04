//
//  CommentsList.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import SwiftUI
import CloudKit

struct CommentsList: View {
    @EnvironmentObject var postViewModel: PostViewModel
    var originalPost: Post
    
    var body: some View {
        VStack {
            CommentCell(
                comment: Comment(message: originalPost.message, author: originalPost.author),
                isOriginalPost: true)
            Divider()
            
            ForEach(postViewModel.comments) { comment in
                CommentCell(comment: comment)
            }
            
            Spacer()
            
            CommentTextField()
        }
        .onAppear {
            Task {
                await postViewModel.fetchComments()
            }
        }
        .navigationTitle("Comments")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CommentsList_Previews: PreviewProvider {
    static var previews: some View {
        CommentsList(originalPost: Post.samplePosts[0])
            .environmentObject(PostViewModel(post: Post.samplePosts[0]))
    }
}
