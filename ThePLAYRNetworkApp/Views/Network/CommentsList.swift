//
//  CommentsList.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import SwiftUI
import CloudKit

struct CommentsList: View {
    @StateObject var commentListViewModel: CommentListViewModel
    @Binding var originalPost: Post
    
    init(originalPost: Binding<Post>) {
        let postID = CKRecord.ID(recordName: originalPost.id)
        self._commentListViewModel = StateObject(wrappedValue: CommentListViewModel(postID: postID))
        self._originalPost = originalPost
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CommentCell(
                    commentViewModel: CommentViewModel(comment: Comment(message: originalPost.message, author: originalPost.author)),
                    isOriginalPost: true)
                
                Divider()
                
                if commentListViewModel.isLoading {
                    ProgressView()
                        .padding(.top)
                }
                
                ForEach(commentListViewModel.comments) { comment in
                    CommentCell(commentViewModel: comment)
                }
                
                Spacer()
//                    .padding(.top, 50)
            }
            .padding(.bottom, 60)
        }
        .navigationTitle("\(originalPost.numberOfComments) Comments")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            Task {
                await commentListViewModel.fetchComments()
            }
        }
        .overlay(alignment: .bottom) {
            VStack(spacing: 0) {
                            
                Divider()
                
                HStack(alignment: .center, spacing: 10) {
                    TextField("Add a comment...", text: $commentListViewModel.text)
                        .padding(7)
                        .background(.regularMaterial)
                        .font(.system(size: 14))
                        .submitLabel(.send)
                        .onSubmit {
                            Task {
                                await commentListViewModel.createComment()
                                originalPost.numberOfComments += 1
                            }
                        }
                }
                .font(.system(size: 24))
                .foregroundColor(Color.ui.gray959595)
                .padding()
                
            }
            .background(Color.ui.white)
        }
    }
}

struct CommentsList_Previews: PreviewProvider {
    static var previews: some View {
        CommentsList(originalPost: .constant(Post.samplePosts[0]))
            .environmentObject(PostViewModel(post: Post.samplePosts[0]))
    }
}
