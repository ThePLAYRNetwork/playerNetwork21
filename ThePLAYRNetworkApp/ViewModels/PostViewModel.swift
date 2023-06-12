//
//  PostViewModel.swift
//  ThePLAYRNetworkApp
//
//  Created by Timmy Nguyen on 5/24/23.
//

import Foundation
import CloudKit

// TOOD: Stop user from spamming likes
@MainActor
class PostViewModel: ObservableObject, Identifiable {
    @Published var post: Post
    
    let postRepository = PostRepository()
    
    var id: String { return post.id }
    
    init(post: Post) {
        self.post = post
    }

    func onTappedLikeButton() async {
        if post.isLiked {
            await unlikePost()
        } else {
            await likePost()
        }
    }
    
    func likePost() async {
        let prevLikes = post.numberOfLikes
        post.numberOfLikes += 1
        post.isLiked = true
        let results = await postRepository.likePost(post: post)
        switch results {
        case .success(let _):
            post.isLiked = true
        case .failure(let error):
            post.numberOfLikes = prevLikes
            post.isLiked = false
        }
    }
    
    func unlikePost() async {
        let prevLikes = post.numberOfLikes
        post.numberOfLikes -= 1
        post.isLiked = false
        let results = await postRepository.unlikePost(post: post)
        switch results {
        case .success(let _):
            post.isLiked = false
        case .failure(let error):
            post.numberOfLikes = prevLikes
            post.isLiked = true
        }
    }
}
