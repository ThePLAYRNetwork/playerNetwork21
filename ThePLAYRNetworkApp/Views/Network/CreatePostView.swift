//
//  CreatePostView.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/21/23.
//

import SwiftUI
import CloudKit

// TODO:
//  - Make message textfield bigger
//  - Remove cover image box
//  - Make cover image row as close to possible with keyboard?
struct CreatePostView: View {
    
    @EnvironmentObject var createPostViewModel : CreatePostViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Create Post")
                    .font(.system(size: 24))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("message".uppercased())
                        .font(.system(size: 12, weight: .medium))
                    
                    TextField(
                        "Post your message",
                        text: $createPostViewModel.post.message,
                        axis: .vertical
                    )
                    .lineLimit(5...10)
                    .modifier(CreateLabel())
                }
                
                GameCoverImageRow()
                GameCoverImage()
                
                Spacer()
                
                Button {
                    // Handle creating post
                    Task {
                        await createPostViewModel.createPost()
                    }
                } label: {
                    Text("Create")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(CustomButton(color: .red, size: .small))
            }
            .padding()
        }
        .onAppear {
            createPostViewModel.post = Post() // clear inputs each time user opens create
        }
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView()
    }
}
