//
//  PostItem.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 9/4/22.
//

import SwiftUI

struct PostItem: View {
    @Binding var post: Post
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Circle()
                    .fill(Color.ui.light_gray)
                    .frame(width: 51, height: 51)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Jared Mills")
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 20))
                                .padding(4)
                        }
                        .buttonStyle(.plain)
                    }
                    Text("Point Guard @school, San Diego")
                        .font(.system(size: 12))
                    Text("5h ago")
                        .font(.system(size: 12))
                }
            }
            
            Text(post.message)
                .padding(.top, 12)
            
            HStack {
                Circle()
                    .fill(Color.ui.light_gray)
                    .frame(width: 14, height: 14)
                
                Text("10")
                
                Spacer()
                
                Text("3 comments")
            }
            .padding(.top, 16)
            .foregroundColor(.gray)
            .font(.system(size: 12))
            
            Divider()
                .padding(.top, 10)
            
            // to each vstack for even spacing -> .frame(maxWidth: .infinity)

            
            HStack(alignment: .bottom) {
                VStack {
                    Image(systemName: "hand.thumbsup")
                    Text("Like")
                }
                
                Spacer()

                VStack {
                    Image(systemName: "message")
                    Text("Comment")
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "arrowshape.turn.up.right")
                    Text("Share")
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "paperplane")
                    Text("Send")
                }
            }
            .foregroundColor(.gray)
            .font(.system(size: 12))
            .padding(.horizontal)
            .padding(.top, 17)
            
        }
        .padding()
        .padding(.top)
    }
}

struct PostItem_Previews: PreviewProvider {
    static var previews: some View {
        PostItem(post: .constant(Post.samplePosts[0]))
            .previewLayout(.sizeThatFits)
    }
}
