//
//  ReplyCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/4/23.
//

import SwiftUI

struct ReplyCell: View {
    @ObservedObject var replyViewModel: ReplyViewModel
    var isOriginalComment = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            AsyncImage(url: replyViewModel.reply.author?.profileImage?.fileURL) { phase in
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
                    Text(replyViewModel.reply.author?.fullName ?? "User not found")
                    Spacer()
//                    Text(formatTwitterDate(comment.createdAt))
                    Text(replyViewModel.reply.createdAt.formatted(date: .abbreviated, time: .shortened))
                }
                .foregroundColor(Color.ui.gray959595)
                .font(.system(size: 12))
                
                Text(replyViewModel.reply.message)
                    .font(.system(size: 14))
                
                if !isOriginalComment {
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            // Handle likes
                            Task {
                                await replyViewModel.onTappedLikeButton()
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.thumbsup")
                                Text("\(replyViewModel.reply.numberOfLikes)")
                            }
                            .foregroundColor(replyViewModel.reply.isLiked ? .accentColor : .gray)
                            .symbolVariant(replyViewModel.reply.isLiked ? .fill : .none)
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
//
//struct ReplyCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ReplyCell(reply: <#Reply#>, commentViewModel: CommentViewModel(comment: Comment.sampleComments[0]))
//            .previewLayout(.sizeThatFits)
//    }
//}
