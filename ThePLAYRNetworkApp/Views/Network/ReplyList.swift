//
//  ReplyList.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/4/23.
//

import SwiftUI

struct ReplyList: View {
    @StateObject var replyListViewModel: ReplyListViewModel
    var originalComment: Comment
    
    init(originalComment: Comment) {
        self._replyListViewModel = StateObject(wrappedValue: ReplyListViewModel(commentID: originalComment.recordID))
        self.originalComment = originalComment
    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                CommentCell(
                    commentViewModel: CommentViewModel(comment: originalComment),
                    isOriginalPost: true)
                
                Divider()
                
                if replyListViewModel.isLoading {
                    ProgressView()
                        .padding(.top)
                }
                
                ForEach(replyListViewModel.replies) { reply in
                    ReplyCell(replyViewModel: reply)
                }
                
                Spacer()
                
            }
        }
        .navigationTitle("\(originalComment.numberOfReplies) Replies")
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            Task {
                await replyListViewModel.fetchReplies()
            }
        }
        .overlay(alignment: .bottom) {
            VStack(spacing: 0) {
                
                Divider()
                
                HStack(alignment: .center, spacing: 10) {
                    TextField("Write a reply...", text: $replyListViewModel.reply.message)
                        .padding(7)
                        .background(.regularMaterial)
                        .font(.system(size: 14))
                        .submitLabel(.send)
                        .onSubmit {
                            Task {
                                await replyListViewModel.createReply()
                            }
                        }
                }
                .font(.system(size: 24))
                .foregroundColor(Color.ui.gray959595)
                .padding()
                
            }
        }
    }
}

//struct ReplyList_Previews: PreviewProvider {
//    static var previews: some View {
//        ReplyList(originalPost: Post.samplePosts[0])
//            .environmentObject(PostViewModel(post: Post.samplePosts[0]))
//    }
//}
