//
//  CommentTextField.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/28/23.
//

import SwiftUI
import CloudKit

struct CommentTextField: View {
    @Binding var message: String
    var createComment: () async -> Void
    
    var body: some View {
        VStack(spacing: 0) {
                        
            Divider()
            
            HStack(alignment: .center, spacing: 10) {
                TextField("Add a comment...", text: $message)
                    .padding(7)
                    .background(.regularMaterial)
                    .font(.system(size: 14))
                    .submitLabel(.send)
                    .onSubmit {
                        Task {
                           await createComment()
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

//struct CommentTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentTextField()
//    }
//}
