//
//  CommentsListViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/5/23.
//

import Foundation
import CloudKit

@MainActor
class CommentListViewModel: ObservableObject, Identifiable {
    @Published var comments: [CommentViewModel] = []
    @Published var text = ""
    @Published var isLoading = false
    
    let postRepository = PostRepository()
    let userRepository = UserRepository()
    var postID: CKRecord.ID
    
    init(postID: CKRecord.ID) {
        self.postID = postID
        Task {
            isLoading = true
            await fetchComments()
            isLoading = false
        }
    }
    
    func fetchComments() async {
        let result = await postRepository.fetchComments(postID: postID)
        switch result {
        case .success(let comments):
            self.comments = comments.map { CommentViewModel(comment: $0) }
        case .failure(let error):
            break
        }
    }
    
    func createComment() async {
        let commentToAdd = Comment(message: text, postID: postID)
        text = ""
        let result = await postRepository.createComment(comment: commentToAdd)
        switch result {
        case .success(let comment):
            print(comment)
            comments.insert(CommentViewModel(comment: comment), at: 0)
            break
        case .failure(let error):
            break
        }
    }
    
}
