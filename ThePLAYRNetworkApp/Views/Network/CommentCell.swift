//
//  CommentCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import SwiftUI
import CloudKit

struct CommentCell: View {
    @ObservedObject var commentViewModel: CommentViewModel
    var isOriginalPost = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            AsyncImage(url: commentViewModel.comment.author?.profileImage?.fileURL) { phase in
                if let image = phase.image {
                    // Displays the loaded image./
                    image
                        .resizable()
                } else {
                    // Acts as a placeholder.
                    Image(systemName: "person.fill")
                        .font(.system(size: 20))
                        .foregroundColor(Color.ui.grayECECEC)
                }
            }
            .frame(width: 30, height: 30)
            .clipShape(Circle())
            .background {
                Circle().fill(Color.ui.grayD9D9D9)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(commentViewModel.comment.author?.fullName ?? "User not found")
                    Spacer()
//                    Text(formatTwitterDate(comment.createdAt))
                    Text(commentViewModel.comment.createdAt.formatted(date: .abbreviated, time: .shortened))
                }
                .foregroundColor(Color.ui.gray959595)
                .font(.system(size: 12))
                
                Text(commentViewModel.comment.message)
                    .font(.system(size: 14))
                
                if !isOriginalPost {
                    HStack {
                        Text("\(commentViewModel.comment.numberOfReplies) replies  |")
                        
                        NavigationLink {
                            ReplyList(originalComment: commentViewModel.comment)
                        } label: {
                            Text("Reply")
                        }
                        
                        Spacer()
                        
                        Button {
                            Task {
                                await commentViewModel.onTappedLikeButton()
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.thumbsup")
                                Text("\(commentViewModel.comment.numberOfLikes)")
                            }
                            .foregroundColor(commentViewModel.comment.isLiked ? .accentColor : .gray)
                            .symbolVariant(commentViewModel.comment.isLiked ? .fill : .none)
                        }
                        .padding(.trailing)
                    }
                    .foregroundColor(Color.ui.gray959595)
                    .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell(commentViewModel: CommentViewModel(comment: Comment.sampleComments[0]))
            .previewLayout(.sizeThatFits)
    }
}
