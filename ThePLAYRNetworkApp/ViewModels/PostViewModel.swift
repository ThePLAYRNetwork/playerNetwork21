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
    @Published var comments = [Comment]()
    @Published var comment: Comment = Comment()
    
    let postRepository = PostRepository()
    var id: String {
        return post.id
    }
    
    init(post: Post) {
        self.post = post
    }
    
    func fetchComments() async {
        let result = await postRepository.fetchComments(postID: post.recordID)
        switch result {
        case .success(let comments):
            self.comments = comments
        case .failure(let error):
            break
        }
    }
    
    func createComment() async {
        comment.postID = CKRecord.Reference(recordID: post.recordID, action: .none)
        let result = await postRepository.createComment(comment: comment)
        switch result {
        case .success(let _):
            break
        case .failure(let error):
            break
        }
    }
    
    func onTappedLikeButton() async {
        if post.isLiked {
            await unlikePost()
        } else {
            await likePost()
        }
    }
    
    func likePost() async {
        let prevLikes = post.likes
        post.likes += 1
        post.isLiked = true
        let results = await postRepository.likePost(post: post)
        switch results {
        case .success(let _):
            post.isLiked = true
        case .failure(let error):
            post.likes = prevLikes
            post.isLiked = false
        }
    }
    
    func unlikePost() async {
        let prevLikes = post.likes
        post.likes -= 1
        post.isLiked = false
        let results = await postRepository.unlikePost(post: post)
        switch results {
        case .success(let _):
            post.isLiked = false
        case .failure(let error):
            post.likes = prevLikes
            post.isLiked = true
        }
    }
}
