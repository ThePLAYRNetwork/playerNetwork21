//
//  CommentTextField.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import SwiftUI
import CloudKit

struct CommentTextField: View {
    @EnvironmentObject var postViewModel: PostViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            Divider()
            
            HStack(alignment: .center, spacing: 10) {
                TextField("Write a message...", text: $postViewModel.comment.message)
                    .padding(7)
                    .background(.regularMaterial)
                    .font(.system(size: 14))
                    .submitLabel(.send)
                    .onSubmit {
                        Task {
                           await postViewModel.createComment()
                        }
                    }
            }
            .font(.system(size: 24))
            .foregroundColor(Color.ui.gray959595)
            .padding()
            
        }
    }
}

struct CommentTextField_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextField()
    }
}
