//
//  CommentViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 6/4/23.
//

import Foundation

@MainActor
class CommentViewModel: ObservableObject, Identifiable {
    @Published var comment: Comment
    
    let postRepository = PostRepository()

    init(comment: Comment) {
        self.comment = comment
    }
    
    func onTappedLikeButton() async {
        if comment.isLiked {
            await unlikeComment()
        } else {
            await likeComment()
        }
    }
    
    func likeComment() async {
        let prevLikes = comment.numberOfLikes
        comment.numberOfLikes += 1
        comment.isLiked = true
        let results = await postRepository.likeComment(comment: comment)
        switch results {
        case .success(let _):
            comment.isLiked = true
        case .failure(let error):
            comment.numberOfLikes = prevLikes
            comment.isLiked = false
        }
    }
    
    func unlikeComment() async {
        let prevLikes = comment.numberOfLikes
        comment.numberOfLikes -= 1
        comment.isLiked = false
        let results = await postRepository.unlikeComment(comment: comment)
        switch results {
        case .success(let _):
            comment.isLiked = false
        case .failure(let error):
            comment.numberOfLikes = prevLikes
            comment.isLiked = true
        }
    }
}
