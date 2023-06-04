//
//  CommentCell.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import SwiftUI
import CloudKit

struct CommentCell: View {
    let comment: Comment
    var isOriginalPost = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 9) {
            AsyncImage(url: comment.author?.profileImage?.fileURL) { phase in
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
                    Text(comment.author?.fullName ?? "User not found")
                    Spacer()
//                    Text(formatTwitterDate(comment.createdAt))
                    Text(comment.createdAt.formatted(date: .abbreviated, time: .shortened))
                }
                .foregroundColor(Color.ui.gray959595)
                .font(.system(size: 12))
                
                Text(comment.message)
                    .font(.system(size: 14))
                
                if !isOriginalPost {
                    HStack {
                        Button {
                            // Handle reply
                        } label: {
                            Text("Reply")
                        }
                        
                        Spacer()
                        
                        Button {
                            // Handle likes
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "hand.thumbsup")
                                Text("0")
                            }
                        }
                        .padding(.trailing)
                        
                        Button {
                            // Handle likes
                        } label: {
                            Image(systemName: "hand.thumbsdown")
                        }
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
        CommentCell(comment: Comment.sampleComments[0])
            .previewLayout(.sizeThatFits)
    }
}
